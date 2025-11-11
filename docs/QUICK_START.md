# 🚀 PickleUp Quick Start Guide

## For Developers

### Prerequisites
- Node.js 18+
- PostgreSQL 14+ with PostGIS
- Flutter 3.x (or React Native 0.72+)
- Git
- Docker (optional)

### Initial Setup

#### 1. Clone Repository
```bash
git clone https://github.com/jrudesyle/pickle-up.git
cd pickle-up
```

#### 2. Backend Setup
```bash
# Create backend directory structure
mkdir -p backend/src/{routes,services,models,middleware,utils}
cd backend

# Initialize Node project
npm init -y

# Install dependencies
npm install fastify @fastify/cors @fastify/jwt
npm install pg postgis typeorm
npm install dotenv zod
npm install -D typescript @types/node ts-node nodemon

# Create .env file
cat > .env << EOF
DATABASE_URL=postgresql://user:password@localhost:5432/pickleup
JWT_SECRET=your-secret-key-change-in-production
TWILIO_ACCOUNT_SID=your-twilio-sid
TWILIO_AUTH_TOKEN=your-twilio-token
GOOGLE_MAPS_API_KEY=your-google-maps-key
PORT=3000
EOF

# Start development server
npm run dev
```

#### 3. Database Setup
```bash
# Create database
createdb pickleup

# Enable PostGIS extension
psql pickleup -c "CREATE EXTENSION postgis;"

# Run migrations (once implemented)
npm run migrate
```

#### 4. Mobile Setup

**For Flutter:**
```bash
cd mobile
flutter pub get
flutter run
```

**For React Native:**
```bash
cd mobile
npm install
npx pod-install  # iOS only
npm run ios      # or: npm run android
```

---

## Project Structure

```
pickle-up/
├── backend/
│   ├── src/
│   │   ├── routes/        # API endpoints
│   │   ├── services/      # Business logic
│   │   ├── models/        # Database models
│   │   ├── middleware/    # Auth, validation
│   │   └── utils/         # Helpers
│   ├── tests/
│   └── package.json
├── mobile/
│   ├── lib/               # Flutter source
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── services/
│   │   └── models/
│   └── pubspec.yaml
├── docs/
│   ├── API.md
│   ├── ARCHITECTURE.md
│   ├── DATA_MODEL.md
│   ├── USER_STORIES.md
│   └── ROADMAP.md
└── README.md
```

---

## Key Commands

### Backend
```bash
npm run dev          # Start dev server with hot reload
npm run build        # Build for production
npm run test         # Run tests
npm run lint         # Lint code
npm run migrate      # Run database migrations
```

### Mobile
```bash
flutter run          # Run on connected device
flutter test         # Run tests
flutter build apk    # Build Android APK
flutter build ios    # Build iOS app
```

---

## Environment Variables

### Backend (.env)
```bash
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/pickleup

# Authentication
JWT_SECRET=your-jwt-secret
JWT_EXPIRATION=7d

# External Services
TWILIO_ACCOUNT_SID=ACxxxxx
TWILIO_AUTH_TOKEN=xxxxx
TWILIO_PHONE_NUMBER=+1234567890
GOOGLE_MAPS_API_KEY=AIzaxxxxx

# Server
PORT=3000
NODE_ENV=development

# Redis (optional)
REDIS_URL=redis://localhost:6379
```

### Mobile (.env)
```bash
API_BASE_URL=http://localhost:3000/v1
GOOGLE_MAPS_API_KEY=AIzaxxxxx
SENTRY_DSN=https://xxxxx@sentry.io/xxxxx
```

---

## Testing

### Backend Tests
```bash
# Unit tests
npm run test:unit

# Integration tests
npm run test:integration

# E2E tests
npm run test:e2e

# Coverage
npm run test:coverage
```

### Mobile Tests
```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widgets

# Integration tests
flutter drive --target=test_driver/app.dart
```

---

## Common Tasks

### Add a New API Endpoint
1. Create route in `backend/src/routes/`
2. Implement service in `backend/src/services/`
3. Add tests in `backend/tests/`
4. Update `docs/API.md`

### Add a New Screen (Mobile)
1. Create screen in `mobile/lib/screens/`
2. Add navigation route
3. Create necessary widgets
4. Add tests

### Database Migration
```bash
# Create migration
npm run migration:create -- AddCourtAmenities

# Run migrations
npm run migrate

# Rollback
npm run migrate:rollback
```

---

## Debugging

### Backend
```bash
# Enable debug logs
DEBUG=* npm run dev

# Inspect database
psql pickleup
\dt  # List tables
\d+ courts  # Describe table
```

### Mobile
```bash
# Flutter DevTools
flutter pub global activate devtools
flutter pub global run devtools

# React Native Debugger
open "rndebugger://set-debugger-loc?host=localhost&port=8081"
```

---

## Deployment

### Backend (Docker)
```bash
docker build -t pickleup-api .
docker run -p 3000:3000 --env-file .env pickleup-api
```

### Mobile
```bash
# Android
flutter build apk --release
# Upload to Google Play Console

# iOS
flutter build ipa
# Upload to App Store Connect
```

---

## Troubleshooting

### "PostGIS extension not found"
```bash
# Install PostGIS
brew install postgis  # macOS
sudo apt-get install postgis  # Ubuntu

# Enable in database
psql pickleup -c "CREATE EXTENSION postgis;"
```

### "Port 3000 already in use"
```bash
# Find and kill process
lsof -ti:3000 | xargs kill -9

# Or change port in .env
PORT=3001
```

### "Flutter command not found"
```bash
# Add to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Or install via Homebrew
brew install flutter
```

---

## Resources

- **API Docs**: http://localhost:3000/docs (Swagger)
- **Database Admin**: http://localhost:5050 (pgAdmin)
- **GitHub**: https://github.com/jrudesyle/pickle-up
- **Slack**: #pickleup-dev (if applicable)

---

## Getting Help

1. Check documentation in `/docs`
2. Search existing GitHub issues
3. Ask in team Slack channel
4. Contact: rudesyle@gmail.com

---

**Happy Coding! 🎾**
