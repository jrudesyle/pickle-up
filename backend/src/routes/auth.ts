import { FastifyPluginAsync } from 'fastify';
import { z } from 'zod';
import bcrypt from 'bcrypt';

const registerSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  name: z.string().min(2),
});

const loginSchema = z.object({
  email: z.string().email(),
  password: z.string(),
});

const authRoutes: FastifyPluginAsync = async (server) => {
  // Register new user
  server.post('/register', async (request, reply) => {
    try {
      const body = registerSchema.parse(request.body);
      
      // Check if user exists
      const existing = await server.prisma.user.findUnique({
        where: { email: body.email },
      });
      
      if (existing) {
        return reply.code(400).send({ error: 'Email already registered' });
      }
      
      // Hash password
      const passwordHash = await bcrypt.hash(body.password, 10);
      
      // Create user
      const user = await server.prisma.user.create({
        data: {
          email: body.email,
          passwordHash,
          name: body.name,
        },
        select: {
          id: true,
          email: true,
          name: true,
          createdAt: true,
        },
      });
      
      // Generate JWT
      const token = server.jwt.sign(
        { userId: user.id, email: user.email },
        { expiresIn: server.config.JWT_EXPIRATION }
      );
      
      return { user, token };
    } catch (error) {
      if (error instanceof z.ZodError) {
        return reply.code(400).send({ error: 'Invalid request', details: error.errors });
      }
      throw error;
    }
  });

  // Login
  server.post('/login', async (request, reply) => {
    try {
      const body = loginSchema.parse(request.body);
      
      // Find user
      const user = await server.prisma.user.findUnique({
        where: { email: body.email },
      });
      
      if (!user || !user.passwordHash) {
        return reply.code(401).send({ error: 'Invalid credentials' });
      }
      
      // Verify password
      const valid = await bcrypt.compare(body.password, user.passwordHash);
      
      if (!valid) {
        return reply.code(401).send({ error: 'Invalid credentials' });
      }
      
      // Generate JWT
      const token = server.jwt.sign(
        { userId: user.id, email: user.email },
        { expiresIn: server.config.JWT_EXPIRATION }
      );
      
      return {
        user: {
          id: user.id,
          email: user.email,
          name: user.name,
        },
        token,
      };
    } catch (error) {
      if (error instanceof z.ZodError) {
        return reply.code(400).send({ error: 'Invalid request', details: error.errors });
      }
      throw error;
    }
  });

  // Get current user (protected route example)
  server.get('/me', {
    onRequest: [server.authenticate],
  }, async (request) => {
    const userId = (request.user as any).userId;
    
    const user = await server.prisma.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        email: true,
        name: true,
        phone: true,
        skillLevel: true,
        avatarUrl: true,
        role: true,
        createdAt: true,
      },
    });
    
    return { user };
  });
};

// JWT authentication decorator
declare module 'fastify' {
  interface FastifyInstance {
    authenticate: any;
  }
}

export default authRoutes;
