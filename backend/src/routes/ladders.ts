import { FastifyPluginAsync } from 'fastify';
import { z } from 'zod';

const createLadderSchema = z.object({
  name: z.string().min(3).max(200),
  description: z.string().optional(),
  format: z.enum(['SINGLES', 'DOUBLES', 'MIXED_DOUBLES']),
  season_start: z.string().transform(str => new Date(str)),
  season_end: z.string().transform(str => new Date(str)),
  home_courts: z.array(z.string()).min(1),
  visibility: z.enum(['PUBLIC', 'PRIVATE', 'INVITE_ONLY']).default('PUBLIC'),
});

const laddersRoutes: FastifyPluginAsync = async (server) => {
  // Create ladder
  server.post('/', {
    onRequest: [server.authenticate],
  }, async (request, reply) => {
    try {
      const userId = (request.user as any).userId;
      const body = createLadderSchema.parse(request.body);
      
      const ladder = await server.prisma.ladder.create({
        data: {
          orgUserId: userId,
          name: body.name,
          description: body.description,
          format: body.format,
          seasonStart: body.season_start,
          seasonEnd: body.season_end,
          homeCourts: body.home_courts,
          visibility: body.visibility,
        },
      });
      
      // Add creator as organizer member
      await server.prisma.ladderMember.create({
        data: {
          ladderId: ladder.id,
          userId,
          role: 'ORGANIZER',
          ranking: 1,
        },
      });
      
      return {
        id: ladder.id,
        name: ladder.name,
        created_at: ladder.createdAt,
      };
    } catch (error) {
      if (error instanceof z.ZodError) {
        return reply.code(400).send({ error: 'Invalid request', details: error.errors });
      }
      throw error;
    }
  });

  // Get ladder by ID
  server.get('/:id', async (request, reply) => {
    const { id } = request.params as { id: string };
    
    const ladder = await server.prisma.ladder.findUnique({
      where: { id },
      include: {
        organizer: {
          select: {
            id: true,
            name: true,
          },
        },
        members: {
          include: {
            user: {
              select: {
                id: true,
                name: true,
                skillLevel: true,
              },
            },
          },
          orderBy: {
            ranking: 'asc',
          },
        },
      },
    });
    
    if (!ladder) {
      return reply.code(404).send({ error: 'Ladder not found' });
    }
    
    return { ladder };
  });

  // Get ladder standings
  server.get('/:id/standings', async (request, reply) => {
    const { id } = request.params as { id: string };
    
    const members = await server.prisma.ladderMember.findMany({
      where: { ladderId: id },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            skillLevel: true,
          },
        },
      },
      orderBy: [
        { points: 'desc' },
        { wins: 'desc' },
      ],
    });
    
    const standings = members.map((member, index) => ({
      rank: index + 1,
      user: member.user,
      points: member.points,
      wins: member.wins,
      losses: member.losses,
      win_percentage: member.wins + member.losses > 0 
        ? (member.wins / (member.wins + member.losses) * 100).toFixed(1)
        : '0.0',
    }));
    
    return { standings };
  });
};

export default laddersRoutes;
