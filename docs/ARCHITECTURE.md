# 🏗️ PickleUp Architecture

## System Overview

PickleUp is a mobile-first application with a RESTful backend, real-time features, and geospatial capabilities.

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Mobile Clients                          │
│              (iOS & Android - Flutter/RN)                   │
└────────────┬────────────────────────────────┬───────────────┘
             │                                │
             │ REST API                       │ WebSocket
             │                                │
┌────────────▼────────────────────────────────▼───────────────┐
│                      API Gateway                            │
│                   (Load Balancer)                           │
└────────────┬────────────────────────────────┬───────────────┘
             │                                │
    ┌────────▼────────┐              ┌───────▼────────┐
    │  Backend API    │              │  WebSocket     │
    │  (Node + TS)    │              │  Server        │
    └────────┬────────┘              └───────┬────────┘
             │                                │
    ┌────────▼────────────────────────────────▼────────┐
    │         PostgreSQL + PostGIS                     │
    │         (Primary Database)                       │
    └──────────────────────────────────────────────────┘
             │
    ┌────────▼────────┐
    │  Redis Cache    │
    │  (Sessions)     │
    └─────────────────┘

External Services:
├── Firebase/APNs (Push Notifications)
├── Twilio (SMS)
├── SendGrid/SES (Email)
├── Google Maps API (Geocoding, Directions)
└── Auth0/Cognito (Authentication)
```

## Technology Stack

### Mobile
- **Framework**: Flutter (Dart) or React Native
- **State Management**: Riverpod (Flutter) / Redux (RN)
- **Maps**: Google Maps SDK / Apple MapKit
- **Local Storage**: SQLite / Hive
- **HTTP Client**: Dio / Axios

### Backend
- **Runtime**: Node.js 18+
- **Framework**: Fastify or NestJS
- **Language**: TypeScript
- **ORM**: Prisma or TypeORM
- **Validation**: Zod
- **Testing**: Jest + Supertest

### Database
- **Primary**: PostgreSQL 14+ with PostGIS
- **Cache**: Redis 7+
- **Search**: PostgreSQL Full-Text Search

### Infrastructure
- **Hosting**: AWS (ECS/Fargate) or Render
- **CDN**: CloudFront or Cloudflare
- **Storage**: S3 (images, backups)
- **Monitoring**: DataDog or New Relic
- **Logging**: CloudWatch or Papertrail

## Core Services

### 1. Court Service
**Responsibilities**:
- Court CRUD operations
- Geospatial queries (nearby courts)
- Check-in management
- Crowding calculations

**Key Endpoints**:
- `GET /courts?lat={lat}&lng={lng}&radius={m}` - Find nearby courts
- `POST /courts/{id}/checkins` - Start check-in
- `GET /courts/{id}/crowding` - Get real-time crowd level

### 2. Ladder Service
**Responsibilities**:
- Ladder lifecycle management
- Member roster
- Invitation system
- Standings calculations

**Key Endpoints**:
- `POST /ladders` - Create ladder
- `POST /ladders/{id}/members` - Add member
- `GET /ladders/{id}/standings` - Get rankings

### 3. Match Service
**Responsibilities**:
- Match scheduling (AutoServe algorithm)
- Result submission & confirmation
- Calendar integration
- Conflict detection

**Key Endpoints**:
- `POST /ladders/{id}/matchmaker/run` - Generate matches
- `POST /matches/{id}/result` - Submit result
- `PUT /matches/{id}/confirm` - Confirm result

### 4. Notification Service
**Responsibilities**:
- Multi-channel delivery (push, SMS, email)
- Preference management
- Quiet hours enforcement
- Template rendering

**Key Endpoints**:
- `GET /users/me/notifications` - Get notification history
- `PUT /users/me/notification-preferences` - Update settings

### 5. User Service
**Responsibilities**:
- Authentication & authorization
- Profile management
- Favorites
- Onboarding flow

**Key Endpoints**:
- `POST /auth/otp/send` - Send OTP
- `POST /auth/otp/verify` - Verify OTP
- `GET /users/me` - Get profile

## Data Flow Examples

### Check-In Flow
```
1. User taps "Check In" → Mobile validates GPS location
2. POST /courts/{id}/checkins with location + duration
3. Backend validates:
   - Distance < 300m from court
   - No active check-in exists
4. Create CourtCheckin record
5. Broadcast crowding update via WebSocket
6. Return success + expiration time
7. Mobile starts background timer
8. On expiration: Auto-update status to 'expired'
```

### Match Scheduling (AutoServe)
```
1. Organizer triggers "Generate Matches"
2. POST /ladders/{id}/matchmaker/run
3. Backend algorithm:
   a. Fetch all members + availability
   b. Sort by ranking
   c. Pair adjacent ranks (1v2, 3v4, etc.)
   d. Find overlapping time slots
   e. Assign courts from home_courts[]
4. Create Match records with status='scheduled'
5. Send notifications to all participants
6. Return match list to organizer for approval
```

## Security

### Authentication
- **Primary**: Phone OTP (Twilio Verify)
- **Secondary**: Email magic links
- **Social**: Google/Apple Sign-In
- **Tokens**: JWT with 7-day expiration
- **Refresh**: Refresh tokens stored in Redis

### Authorization
- **Role-Based Access Control (RBAC)**:
  - `player`: Basic court access
  - `organizer`: Ladder management
  - `facility_manager`: Court verification
  - `admin`: Full system access

### Data Protection
- **At Rest**: PostgreSQL encryption (AWS RDS)
- **In Transit**: TLS 1.3
- **PII**: Encrypted phone/email fields
- **Passwords**: N/A (passwordless auth)

## Performance Targets

| Metric | Target | Strategy |
|--------|--------|----------|
| Map load time | < 1.5s | Redis cache + CDN |
| API response (p95) | < 300ms | Indexed queries + caching |
| Check-in validation | < 500ms | PostGIS spatial index |
| Match generation | < 5s | Optimized algorithm + queue |
| Push notification | < 10s | Firebase batching |
| Uptime | 99.9% | Multi-AZ deployment |

## Scalability

### Horizontal Scaling
- **API Servers**: Auto-scale based on CPU (2-10 instances)
- **WebSocket**: Sticky sessions with Redis pub/sub
- **Database**: Read replicas for analytics queries

### Caching Strategy
- **Court Data**: 5-minute TTL (frequently changing crowding)
- **User Profiles**: 1-hour TTL
- **Ladder Standings**: Invalidate on result confirmation
- **Static Assets**: CDN with 1-year TTL

### Database Optimization
- **Indexes**: All foreign keys + geospatial columns
- **Partitioning**: `court_checkins` by month
- **Archiving**: Move completed matches > 1 year to cold storage

## Monitoring & Observability

### Key Metrics
- **Business**: DAU, check-ins/day, ladders created
- **Technical**: API latency, error rate, DB connections
- **Infrastructure**: CPU, memory, disk I/O

### Alerting
- API error rate > 5% (5 min window)
- Database connections > 80%
- Check-in validation failures > 10%
- Push notification delivery < 90%

### Logging
- **Structured JSON logs** with request ID tracing
- **Log Levels**: ERROR (alerts), WARN (review), INFO (audit)
- **Retention**: 30 days hot, 1 year cold

## Disaster Recovery

- **Backups**: Daily automated snapshots (7-day retention)
- **RTO**: 4 hours (Recovery Time Objective)
- **RPO**: 1 hour (Recovery Point Objective)
- **Failover**: Multi-region standby (future)

## Development Workflow

```
Feature Branch → PR → CI Tests → Code Review → Merge → Deploy Staging → QA → Production
```

### CI/CD Pipeline
1. **Lint**: ESLint + Prettier
2. **Test**: Unit + Integration (Jest)
3. **Build**: Docker image
4. **Security Scan**: Snyk
5. **Deploy**: Blue-green deployment

## API Versioning

- **URL-based**: `/v1/courts`, `/v2/courts`
- **Deprecation**: 6-month notice
- **Sunset**: Remove after 1 year

## Future Enhancements

- **GraphQL API**: For complex client queries
- **Microservices**: Split services as scale demands
- **ML Features**: Skill prediction, match recommendations
- **Offline Mode**: Full offline court browsing
- **Analytics Pipeline**: Kafka + Data warehouse
