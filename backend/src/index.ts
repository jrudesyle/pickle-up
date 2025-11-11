import Fastify from 'fastify';
import cors from '@fastify/cors';
import jwt from '@fastify/jwt';
import env from '@fastify/env';
import { PrismaClient } from '@prisma/client';

// Middleware
import { authenticate } from './middleware/auth';

// Routes
import healthRoutes from './routes/health';
import authRoutes from './routes/auth';
import courtsRoutes from './routes/courts';
import laddersRoutes from './routes/ladders';
import matchesRoutes from './routes/matches';

const prisma = new PrismaClient();

const envSchema = {
  type: 'object',
  required: ['DATABASE_URL', 'JWT_SECRET'],
  properties: {
    PORT: { type: 'number', default: 3000 },
    HOST: { type: 'string', default: '0.0.0.0' },
    NODE_ENV: { type: 'string', default: 'development' },
    DATABASE_URL: { type: 'string' },
    JWT_SECRET: { type: 'string' },
    JWT_EXPIRATION: { type: 'string', default: '7d' },
  },
};

async function buildServer() {
  const server = Fastify({
    logger: {
      level: process.env.NODE_ENV === 'production' ? 'info' : 'debug',
      transport:
        process.env.NODE_ENV === 'development'
          ? { target: 'pino-pretty' }
          : undefined,
    },
  });

  // Register environment variables
  await server.register(env, {
    schema: envSchema,
    dotenv: true,
  });

  // Register CORS
  await server.register(cors, {
    origin: true, // Allow all origins in development
    credentials: true,
  });

  // Register JWT
  await server.register(jwt, {
    secret: server.config.JWT_SECRET,
  });

  // Add Prisma to Fastify instance
  server.decorate('prisma', prisma);
  
  // Add authentication decorator
  server.decorate('authenticate', authenticate);

  // Health check
  server.get('/', async () => {
    return { 
      status: 'ok', 
      service: 'PickleUp API',
      version: '0.1.0',
      timestamp: new Date().toISOString()
    };
  });

  // Register routes
  await server.register(healthRoutes, { prefix: '/v1/health' });
  await server.register(authRoutes, { prefix: '/v1/auth' });
  await server.register(courtsRoutes, { prefix: '/v1/courts' });
  await server.register(laddersRoutes, { prefix: '/v1/ladders' });
  await server.register(matchesRoutes, { prefix: '/v1/matches' });

  // Graceful shutdown
  const listeners = ['SIGINT', 'SIGTERM'];
  listeners.forEach((signal) => {
    process.on(signal, async () => {
      await server.close();
      await prisma.$disconnect();
      process.exit(0);
    });
  });

  return server;
}

async function start() {
  try {
    const server = await buildServer();
    const port = server.config.PORT;
    const host = server.config.HOST;

    await server.listen({ port, host });
    
    server.log.info(`🎾 PickleUp API running on http://${host}:${port}`);
    server.log.info(`📚 Environment: ${server.config.NODE_ENV}`);
  } catch (err) {
    console.error('Error starting server:', err);
    process.exit(1);
  }
}

// Type augmentation for Fastify
declare module 'fastify' {
  interface FastifyInstance {
    config: {
      PORT: number;
      HOST: string;
      NODE_ENV: string;
      DATABASE_URL: string;
      JWT_SECRET: string;
      JWT_EXPIRATION: string;
    };
    prisma: PrismaClient;
  }
}

// Start server if this file is run directly
if (require.main === module) {
  start();
}

export { buildServer };
