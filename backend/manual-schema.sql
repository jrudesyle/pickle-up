-- PickleUp Manual Schema Creation
-- Run this if Prisma migrations fail

CREATE TYPE "UserRole" AS ENUM ('PLAYER', 'ORGANIZER', 'FACILITY_MANAGER', 'ADMIN');
CREATE TYPE "CourtType" AS ENUM ('OUTDOOR', 'INDOOR', 'MIXED');
CREATE TYPE "CheckinStatus" AS ENUM ('ACTIVE', 'EXPIRED', 'CANCELLED');
CREATE TYPE "LadderFormat" AS ENUM ('SINGLES', 'DOUBLES', 'MIXED_DOUBLES');
CREATE TYPE "LadderVisibility" AS ENUM ('PUBLIC', 'PRIVATE', 'INVITE_ONLY');
CREATE TYPE "LadderStatus" AS ENUM ('DRAFT', 'ACTIVE', 'PAUSED', 'COMPLETED');
CREATE TYPE "MemberRole" AS ENUM ('ORGANIZER', 'MEMBER');
CREATE TYPE "MatchStatus" AS ENUM ('SCHEDULED', 'CONFIRMED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED', 'FORFEITED');
CREATE TYPE "InviteStatus" AS ENUM ('PENDING', 'ACCEPTED', 'DECLINED', 'EXPIRED');
CREATE TYPE "NotificationStatus" AS ENUM ('PENDING', 'SENT', 'FAILED', 'READ');
CREATE TYPE "SuggestionStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- Users table
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash TEXT,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(20) UNIQUE,
  skill_level DECIMAL(2,1),
  timezone VARCHAR(50) DEFAULT 'America/New_York',
  push_token VARCHAR(255),
  avatar_url TEXT,
  role "UserRole" DEFAULT 'PLAYER',
  email_verified BOOLEAN DEFAULT FALSE,
  phone_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  last_seen_at TIMESTAMP,
  deleted_at TIMESTAMP
);

-- Courts table
CREATE TABLE courts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(200) NOT NULL,
  address TEXT NOT NULL,
  latitude DECIMAL(10,8) NOT NULL,
  longitude DECIMAL(11,8) NOT NULL,
  type "CourtType" DEFAULT 'OUTDOOR',
  surface VARCHAR(30),
  has_lights BOOLEAN DEFAULT FALSE,
  is_free BOOLEAN DEFAULT TRUE,
  fee_amount DECIMAL(6,2),
  fee_description TEXT,
  courts_count INTEGER DEFAULT 1,
  open_hours JSONB,
  amenities TEXT[],
  description TEXT,
  website_url TEXT,
  phone VARCHAR(20),
  verified BOOLEAN DEFAULT FALSE,
  verified_at TIMESTAMP,
  photos TEXT[],
  managed_by_id UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP
);

CREATE INDEX idx_courts_location ON courts(latitude, longitude);
CREATE INDEX idx_courts_type ON courts(type);

-- Check-ins table
CREATE TABLE court_checkins (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  court_id UUID NOT NULL REFERENCES courts(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  start_at TIMESTAMP DEFAULT NOW(),
  end_at TIMESTAMP NOT NULL,
  duration_min INTEGER NOT NULL,
  status "CheckinStatus" DEFAULT 'ACTIVE',
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_checkins_court_active ON court_checkins(court_id, status, end_at);

-- User favorites
CREATE TABLE user_favorites (
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  court_id UUID NOT NULL REFERENCES courts(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (user_id, court_id)
);

-- Ladders
CREATE TABLE ladders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  org_user_id UUID NOT NULL REFERENCES users(id),
  name VARCHAR(200) NOT NULL,
  description TEXT,
  format "LadderFormat" DEFAULT 'SINGLES',
  season_start DATE NOT NULL,
  season_end DATE NOT NULL,
  home_courts TEXT[] NOT NULL,
  visibility "LadderVisibility" DEFAULT 'PUBLIC',
  max_members INTEGER DEFAULT 50,
  status "LadderStatus" DEFAULT 'ACTIVE',
  settings JSONB DEFAULT '{}',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Ladder members
CREATE TABLE ladder_members (
  ladder_id UUID NOT NULL REFERENCES ladders(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role "MemberRole" DEFAULT 'MEMBER',
  skill_band VARCHAR(10),
  availability_windows JSONB,
  notify_pref VARCHAR(20) DEFAULT 'all',
  ranking INTEGER,
  points INTEGER DEFAULT 0,
  wins INTEGER DEFAULT 0,
  losses INTEGER DEFAULT 0,
  joined_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (ladder_id, user_id)
);

-- Matches
CREATE TABLE matches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ladder_id UUID NOT NULL REFERENCES ladders(id) ON DELETE CASCADE,
  court_id UUID REFERENCES courts(id) ON DELETE SET NULL,
  status "MatchStatus" DEFAULT 'SCHEDULED',
  start_at TIMESTAMP NOT NULL,
  end_at TIMESTAMP,
  team_a TEXT[] NOT NULL,
  team_b TEXT[] NOT NULL,
  proposed_slots JSONB,
  declined_by TEXT[],
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Match results
CREATE TABLE match_results (
  match_id UUID PRIMARY KEY REFERENCES matches(id) ON DELETE CASCADE,
  sets JSONB NOT NULL,
  winner VARCHAR(6) NOT NULL,
  submitted_by UUID NOT NULL REFERENCES users(id),
  confirmed_by UUID REFERENCES users(id),
  confirmed_at TIMESTAMP,
  dispute_reason TEXT,
  disputed_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Notifications
CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type VARCHAR(50) NOT NULL,
  title VARCHAR(200) NOT NULL,
  body TEXT NOT NULL,
  data JSONB,
  channels TEXT[],
  status "NotificationStatus" DEFAULT 'PENDING',
  sent_at TIMESTAMP,
  read_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Ladder invites
CREATE TABLE ladder_invites (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ladder_id UUID NOT NULL REFERENCES ladders(id) ON DELETE CASCADE,
  invited_by UUID NOT NULL REFERENCES users(id),
  phone VARCHAR(20),
  email VARCHAR(255),
  token VARCHAR(100) UNIQUE NOT NULL,
  status "InviteStatus" DEFAULT 'PENDING',
  expires_at TIMESTAMP NOT NULL,
  accepted_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Court edit suggestions
CREATE TABLE court_edit_suggestions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  court_id UUID NOT NULL REFERENCES courts(id) ON DELETE CASCADE,
  suggested_by UUID NOT NULL REFERENCES users(id),
  field_name VARCHAR(50) NOT NULL,
  old_value TEXT,
  new_value TEXT NOT NULL,
  reason TEXT,
  status "SuggestionStatus" DEFAULT 'PENDING',
  reviewed_by UUID REFERENCES users(id),
  reviewed_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);
