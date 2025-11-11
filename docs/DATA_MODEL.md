# 🗄️ PickleUp Data Model

## Overview

Database schema for PickleUp using PostgreSQL 14+ with PostGIS extension.

---

## Core Entities

### User
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  phone VARCHAR(20) UNIQUE,
  email VARCHAR(255) UNIQUE,
  name VARCHAR(100) NOT NULL,
  skill_level DECIMAL(2,1) CHECK (skill_level >= 2.0 AND skill_level <= 5.5),
  timezone VARCHAR(50) DEFAULT 'America/New_York',
  push_token VARCHAR(255),
  location_home GEOGRAPHY(POINT, 4326),
  avatar_url TEXT,
  role VARCHAR(20) DEFAULT 'player',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Court
```sql
CREATE TABLE courts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(200) NOT NULL,
  address TEXT NOT NULL,
  location GEOGRAPHY(POINT, 4326) NOT NULL,
  type VARCHAR(20) DEFAULT 'outdoor',
  surface VARCHAR(30),
  has_lights BOOLEAN DEFAULT FALSE,
  is_free BOOLEAN DEFAULT TRUE,
  courts_count INTEGER DEFAULT 1,
  open_hours JSONB,
  amenities TEXT[],
  verified BOOLEAN DEFAULT FALSE,
  managed_by UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW()
);
```

### CourtCheckin
```sql
CREATE TABLE court_checkins (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  court_id UUID NOT NULL REFERENCES courts(id),
  user_id UUID NOT NULL REFERENCES users(id),
  start_at TIMESTAMP DEFAULT NOW(),
  end_at TIMESTAMP NOT NULL,
  duration_min INTEGER NOT NULL,
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Ladder
```sql
CREATE TABLE ladders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  org_user_id UUID NOT NULL REFERENCES users(id),
  name VARCHAR(200) NOT NULL,
  format VARCHAR(20) DEFAULT 'singles',
  season_start DATE NOT NULL,
  season_end DATE NOT NULL,
  home_courts UUID[],
  visibility VARCHAR(20) DEFAULT 'public',
  settings JSONB DEFAULT '{}',
  created_at TIMESTAMP DEFAULT NOW()
);
```

### LadderMember
```sql
CREATE TABLE ladder_members (
  ladder_id UUID NOT NULL REFERENCES ladders(id),
  user_id UUID NOT NULL REFERENCES users(id),
  role VARCHAR(20) DEFAULT 'member',
  availability_windows JSONB,
  ranking INTEGER,
  points INTEGER DEFAULT 0,
  wins INTEGER DEFAULT 0,
  losses INTEGER DEFAULT 0,
  PRIMARY KEY (ladder_id, user_id)
);
```

### Match
```sql
CREATE TABLE matches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ladder_id UUID NOT NULL REFERENCES ladders(id),
  court_id UUID REFERENCES courts(id),
  status VARCHAR(20) DEFAULT 'scheduled',
  start_at TIMESTAMP NOT NULL,
  team_a UUID[] NOT NULL,
  team_b UUID[] NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### MatchResult
```sql
CREATE TABLE match_results (
  match_id UUID PRIMARY KEY REFERENCES matches(id),
  sets JSONB NOT NULL,
  winner VARCHAR(6) NOT NULL,
  submitted_by UUID NOT NULL REFERENCES users(id),
  confirmed_by UUID REFERENCES users(id),
  confirmed_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);
```

See full schema details in `/backend/db/schema.sql`
