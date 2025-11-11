import { FastifyPluginAsync } from 'fastify';
import { z } from 'zod';

const submitResultSchema = z.object({
  sets: z.array(z.object({
    team_a: z.number().min(0).max(21),
    team_b: z.number().min(0).max(21),
  })).min(1).max(5),
  winner: z.enum(['team_a', 'team_b', 'draw']),
});

const matchesRoutes: FastifyPluginAsync = async (server) => {
  // Get match by ID
  server.get('/:id', async (request, reply) => {
    const { id } = request.params as { id: string };
    
    const match = await server.prisma.match.findUnique({
      where: { id },
      include: {
        ladder: {
          select: {
            id: true,
            name: true,
          },
        },
        court: {
          select: {
            id: true,
            name: true,
            address: true,
          },
        },
        result: true,
      },
    });
    
    if (!match) {
      return reply.code(404).send({ error: 'Match not found' });
    }
    
    return { match };
  });

  // Submit match result
  server.post('/:id/result', {
    onRequest: [server.authenticate],
  }, async (request, reply) => {
    try {
      const { id } = request.params as { id: string };
      const userId = (request.user as any).userId;
      const body = submitResultSchema.parse(request.body);
      
      // Check if match exists
      const match = await server.prisma.match.findUnique({
        where: { id },
      });
      
      if (!match) {
        return reply.code(404).send({ error: 'Match not found' });
      }
      
      // Verify user is in the match
      const isParticipant = [...match.teamA, ...match.teamB].includes(userId);
      if (!isParticipant) {
        return reply.code(403).send({ error: 'Not a participant in this match' });
      }
      
      // Check if result already exists
      const existingResult = await server.prisma.matchResult.findUnique({
        where: { matchId: id },
      });
      
      if (existingResult) {
        return reply.code(400).send({ error: 'Result already submitted' });
      }
      
      // Create result
      const result = await server.prisma.matchResult.create({
        data: {
          matchId: id,
          sets: body.sets,
          winner: body.winner,
          submittedBy: userId,
        },
      });
      
      // Update match status
      await server.prisma.match.update({
        where: { id },
        data: { status: 'COMPLETED' },
      });
      
      // Determine opponents who need to confirm
      const opponents = match.teamA.includes(userId) ? match.teamB : match.teamA;
      
      return {
        result_id: result.matchId,
        status: 'pending_confirmation',
        confirmation_required_from: opponents,
      };
    } catch (error) {
      if (error instanceof z.ZodError) {
        return reply.code(400).send({ error: 'Invalid request', details: error.errors });
      }
      throw error;
    }
  });

  // Confirm match result
  server.put('/:id/confirm', {
    onRequest: [server.authenticate],
  }, async (request, reply) => {
    const { id } = request.params as { id: string };
    const userId = (request.user as any).userId;
    
    const result = await server.prisma.matchResult.findUnique({
      where: { matchId: id },
      include: {
        match: true,
      },
    });
    
    if (!result) {
      return reply.code(404).send({ error: 'Result not found' });
    }
    
    if (result.confirmedBy) {
      return reply.code(400).send({ error: 'Result already confirmed' });
    }
    
    // Verify user is opponent
    const isOpponent = result.submittedBy !== userId && 
      [...result.match.teamA, ...result.match.teamB].includes(userId);
    
    if (!isOpponent) {
      return reply.code(403).send({ error: 'Not authorized to confirm' });
    }
    
    // Confirm result
    await server.prisma.matchResult.update({
      where: { matchId: id },
      data: {
        confirmedBy: userId,
        confirmedAt: new Date(),
      },
    });
    
    // Update ladder standings
    await updateLadderStandings(server, result.match.ladderId, result);
    
    return {
      status: 'confirmed',
      confirmed_at: new Date().toISOString(),
    };
  });
};

// Helper: Update ladder standings after confirmed result
async function updateLadderStandings(
  server: any,
  ladderId: string,
  result: any
) {
  const pointsWin = 3;
  const pointsLoss = 1;
  
  const winnerTeam = result.winner === 'team_a' ? result.match.teamA : result.match.teamB;
  const loserTeam = result.winner === 'team_a' ? result.match.teamB : result.match.teamA;
  
  // Update winners
  for (const userId of winnerTeam) {
    await server.prisma.ladderMember.update({
      where: {
        ladderId_userId: {
          ladderId,
          userId,
        },
      },
      data: {
        points: { increment: pointsWin },
        wins: { increment: 1 },
      },
    });
  }
  
  // Update losers
  for (const userId of loserTeam) {
    await server.prisma.ladderMember.update({
      where: {
        ladderId_userId: {
          ladderId,
          userId,
        },
      },
      data: {
        points: { increment: pointsLoss },
        losses: { increment: 1 },
      },
    });
  }
}

export default matchesRoutes;
