import { FastifyPluginAsync } from 'fastify';
import { z } from 'zod';

const nearbyQuerySchema = z.object({
  lat: z.string().transform(Number),
  lng: z.string().transform(Number),
  radius: z.string().transform(Number).default('5000'), // meters
  type: z.enum(['OUTDOOR', 'INDOOR', 'MIXED']).optional(),
  hasLights: z.string().transform(val => val === 'true').optional(),
  isFree: z.string().transform(val => val === 'true').optional(),
});

const courtsRoutes: FastifyPluginAsync = async (server) => {
  // Get nearby courts
  server.get('/', async (request, reply) => {
    try {
      const query = nearbyQuerySchema.parse(request.query);
      
      // For now, return all courts (we'll add PostGIS distance calculation later)
      const courts = await server.prisma.court.findMany({
        where: {
          deletedAt: null,
          ...(query.type && { type: query.type }),
          ...(query.hasLights !== undefined && { hasLights: query.hasLights }),
          ...(query.isFree !== undefined && { isFree: query.isFree }),
        },
        select: {
          id: true,
          name: true,
          address: true,
          latitude: true,
          longitude: true,
          type: true,
          surface: true,
          hasLights: true,
          isFree: true,
          courtsCount: true,
          amenities: true,
          verified: true,
        },
        take: 50,
      });
      
      // Calculate distance for each court (simplified - will use PostGIS later)
      const courtsWithDistance = courts.map(court => {
        const distance = calculateDistance(
          query.lat,
          query.lng,
          Number(court.latitude),
          Number(court.longitude)
        );
        
        return {
          ...court,
          distance_m: Math.round(distance),
        };
      }).filter(court => court.distance_m <= query.radius)
        .sort((a, b) => a.distance_m - b.distance_m);
      
      return {
        courts: courtsWithDistance,
        total: courtsWithDistance.length,
      };
    } catch (error) {
      if (error instanceof z.ZodError) {
        return reply.code(400).send({ error: 'Invalid query parameters', details: error.errors });
      }
      throw error;
    }
  });

  // Get court by ID
  server.get('/:id', async (request, reply) => {
    const { id } = request.params as { id: string };
    
    const court = await server.prisma.court.findUnique({
      where: { id },
      include: {
        managedBy: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });
    
    if (!court || court.deletedAt) {
      return reply.code(404).send({ error: 'Court not found' });
    }
    
    // Get active check-ins for crowding
    const activeCheckins = await server.prisma.courtCheckin.count({
      where: {
        courtId: id,
        status: 'ACTIVE',
        endAt: {
          gte: new Date(),
        },
      },
    });
    
    const crowdingLevel = getCrowdingLevel(activeCheckins);
    
    return {
      court,
      crowding: {
        level: crowdingLevel,
        active_checkins: activeCheckins,
        updated_at: new Date().toISOString(),
      },
    };
  });

  // Check in to a court
  server.post('/:id/checkins', {
    onRequest: [server.authenticate],
  }, async (request, reply) => {
    const { id } = request.params as { id: string };
    const userId = (request.user as any).userId;
    const body = z.object({
      duration_min: z.enum(['30', '60', '90']).transform(Number),
      location: z.object({
        lat: z.number(),
        lng: z.number(),
      }),
    }).parse(request.body);
    
    // Check if court exists
    const court = await server.prisma.court.findUnique({
      where: { id },
    });
    
    if (!court) {
      return reply.code(404).send({ error: 'Court not found' });
    }
    
    // Validate distance (simplified - should use PostGIS)
    const distance = calculateDistance(
      body.location.lat,
      body.location.lng,
      Number(court.latitude),
      Number(court.longitude)
    );
    
    if (distance > 300) {
      return reply.code(400).send({ 
        error: 'Too far from court',
        distance_m: Math.round(distance),
        max_distance_m: 300,
      });
    }
    
    // Cancel any existing active check-ins for this user
    await server.prisma.courtCheckin.updateMany({
      where: {
        userId,
        status: 'ACTIVE',
      },
      data: {
        status: 'CANCELLED',
      },
    });
    
    // Create new check-in
    const endAt = new Date(Date.now() + body.duration_min * 60 * 1000);
    const checkin = await server.prisma.courtCheckin.create({
      data: {
        courtId: id,
        userId,
        durationMin: body.duration_min,
        endAt,
      },
    });
    
    // Get updated crowding
    const activeCheckins = await server.prisma.courtCheckin.count({
      where: {
        courtId: id,
        status: 'ACTIVE',
        endAt: {
          gte: new Date(),
        },
      },
    });
    
    return {
      checkin_id: checkin.id,
      expires_at: checkin.endAt,
      crowding: {
        level: getCrowdingLevel(activeCheckins),
        active_checkins: activeCheckins,
      },
    };
  });
};

// Helper: Calculate distance between two points (Haversine formula)
function calculateDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
  const R = 6371e3; // Earth radius in meters
  const φ1 = (lat1 * Math.PI) / 180;
  const φ2 = (lat2 * Math.PI) / 180;
  const Δφ = ((lat2 - lat1) * Math.PI) / 180;
  const Δλ = ((lon2 - lon1) * Math.PI) / 180;

  const a =
    Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
    Math.cos(φ1) * Math.cos(φ2) * Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

  return R * c;
}

// Helper: Determine crowding level
function getCrowdingLevel(count: number): string {
  if (count <= 3) return 'light';
  if (count <= 8) return 'moderate';
  return 'busy';
}

export default courtsRoutes;
