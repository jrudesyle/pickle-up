# PickleUp Backend API

Fastify + TypeScript + Prisma + PostgreSQL/PostGIS

## Quick Start

### 1. Start Docker services
```bash
# From project root
docker-compose up -d
```

### 2. Install dependencies
```bash
cd backend
npm install
```

### 3. Set up database
```bash
# Copy environment variables
cp .env.example .env

# Generate Prisma client
npm run prisma:generate

# Run migrations
npm run prisma:migrate

# (Optional) Seed database
npm run db:seed
```

### 4. Start development server
```bash
npm run dev
```

API will be available at `http://localhost:3000`

## Available Scripts

- `npm run dev` - Start development server with hot reload
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm run prisma:generate` - Generate Prisma client
- `npm run prisma:migrate` - Run database migrations
- `npm run prisma:studio` - Open Prisma Studio (database GUI)
- `npm run db:seed` - Seed database with sample data
- `npm test` - Run tests
- `npm run lint` - Lint code
- `npm run format` - Format code with Prettier

## API Endpoints

### Health
- `GET /` - API status
- `GET /v1/health` - Health check with database status

### Authentication
- `POST /v1/auth/register` - Register new user
- `POST /v1/auth/login` - Login
- `GET /v1/auth/me` - Get current user (protected)

### Courts
- `GET /v1/courts` - Find nearby courts
- `GET /v1/courts/:id` - Get court details
- `POST /v1/courts/:id/checkins` - Check in to court (protected)

### Ladders
- `POST /v1/ladders` - Create ladder (protected)
- `GET /v1/ladders/:id` - Get ladder details
- `GET /v1/ladders/:id/standings` - Get ladder standings

### Matches
- `GET /v1/matches/:id` - Get match details
- `POST /v1/matches/:id/result` - Submit match result (protected)
- `PUT /v1/matches/:id/confirm` - Confirm match result (protected)

## Environment Variables

See `.env.example` for required variables.

## Database

PostgreSQL with PostGIS extension for geospatial queries.

### Migrations

```bash
# Create new migration
npx prisma migrate dev --name add_feature

# Apply migrations
npm run prisma:migrate

# Reset database (WARNING: deletes all data)
npx prisma migrate reset
```

### Prisma Studio

Visual database editor:
```bash
npm run prisma:studio
```

## Testing with ngrok

To test mobile app with local backend:

```bash
# Install ngrok
brew install ngrok

# Start tunnel
ngrok http 3000

# Use the https URL in your mobile app
```

## Docker Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f postgres
docker-compose logs -f redis

# Reset database
docker-compose down -v
docker-compose up -d
```

## Troubleshooting

### Port already in use
```bash
# Find process using port 3000
lsof -ti:3000 | xargs kill -9
```

### Database connection issues
```bash
# Check if PostgreSQL is running
docker ps

# Restart PostgreSQL
docker-compose restart postgres
```

### Prisma client out of sync
```bash
npm run prisma:generate
```
