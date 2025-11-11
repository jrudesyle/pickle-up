# 📱 PickleUp User Stories

## 🧍‍♂️ Personas

### Casual Player – Casey
**Profile**: Plays twice a week; wants open courts now.  
**Primary Goals**: Find courts, check crowding, mark favorites.

### Organizer – Olivia
**Profile**: Runs a community ladder (10–50 players).  
**Primary Goals**: Automate scheduling, manage results easily.

### Facility Manager – Frank
**Profile**: Oversees municipal or club courts.  
**Primary Goals**: Verify info, post closures, maintain hours.

---

## MVP User Stories

### Story 1: Map – Find Courts ("CourtMap")

**As a player, I can open PickleUp and instantly see nearby courts.**

#### Acceptance Criteria
- [ ] Map auto-centers on user's current or saved location
- [ ] Each pin shows crowd status (light / moderate / busy) and basic info (indoor/outdoor, lights, fee)
- [ ] Tap → Court Detail card displays:
  - Address
  - Amenities
  - Verified badge
  - Hours
  - Surface type
  - Number of courts
- [ ] Filters available:
  - Open Now
  - Free Courts
  - Lights On
  - Indoor Only
- [ ] "Get Directions" opens native Maps app
- [ ] "Suggest Edit" button sends change to moderation queue

#### Technical Notes
- Use device GPS with fallback to saved home location
- Implement clustering for dense court areas
- Cache last viewed region for offline access
- Map pins render < 1.5s on LTE

---

### Story 2: Real-Time Crowding ("Check-In Pulse")

**As a player, I can see if a court is busy.**

#### Acceptance Criteria
- [ ] One-tap Check In with duration options (30 / 60 / 90 min)
- [ ] Active check-ins within 300m update live occupancy
- [ ] Crowd levels auto-calculated per court size:
  - 0–3 players = Light (Green)
  - 4–8 players = Moderate (Yellow)
  - 9+ players = Busy (Red)
- [ ] One active check-in per user; duplicates auto-expire
- [ ] Visual: color ring pulse animation around pin
- [ ] Check-in expires automatically after selected duration
- [ ] User can manually end check-in early

#### Technical Notes
- Geo-fence validation: 300m radius
- Exponential smoothing over 15-min window
- Background location updates while checked in
- Battery-efficient location polling

---

### Story 3: Ladder Setup & Roster ("PickleUp Ladders")

**As an organizer, I can create ladders and invite players.**

#### Acceptance Criteria
- [ ] Create ladder with:
  - Name
  - Format (singles/doubles)
  - Home courts (multiple selection)
  - Start/end dates
  - Visibility (public/private)
- [ ] Invite via SMS/email link
- [ ] Non-users can join via OTP (one-time password)
- [ ] Roster displays:
  - Player name
  - Skill level (2.5 – 5.0)
  - Availability windows
  - Contact preferences
- [ ] Organizer can edit/remove members
- [ ] Members can update their own availability

#### Technical Notes
- SMS invites via Twilio
- Email invites with magic links
- OTP valid for 24 hours
- Support up to 100 players per ladder (MVP)

---

### Story 4: Match Scheduling ("AutoServe")

**As an organizer, I want PickleUp to generate weekly matches.**

#### Acceptance Criteria
- [ ] Automatic pairings based on:
  - Ladder order/ranking
  - Player availability windows
  - Recent match history (avoid repeats)
- [ ] System suggests 3 time slots + court options
- [ ] Organizer reviews and approves matches
- [ ] Calendar export to Apple/Google Calendar
- [ ] In-app calendar view with match details
- [ ] Push/SMS reminders:
  - T-24h before match
  - T-3h before match
- [ ] Decline triggers auto-reschedule with next available slot
- [ ] Conflict detection (double-booking prevention)

#### Technical Notes
- Time-zone aware scheduling
- Optimization algorithm for fair pairings
- Webhook integration for calendar sync
- Queue system for reschedule requests

---

### Story 5: Results & Standings

**As a player, I report results and see updated standings.**

#### Acceptance Criteria
- [ ] Input match results:
  - Set scores (best of 3/5)
  - Game scores per set
  - Doubles: capture partner names
- [ ] Opponent confirmation flow:
  - Push notification to opponent
  - Auto-nudge after 12h if no response
  - Auto-nudge after 48h (final)
  - Auto-confirm after 72h
- [ ] Point system:
  - Win = 3 points
  - Loss = 1 point
  - Forfeit = 0 points
- [ ] Standings table:
  - Rank (with movement indicators ↑↓)
  - Player name
  - Wins/Losses
  - Total points
  - Win percentage
  - Color-coded ranks (top 3 highlighted)
- [ ] Updates instantly after confirmation
- [ ] Match history view per player

#### Technical Notes
- Optimistic UI updates with rollback
- Real-time WebSocket for standings
- Historical data retention
- Dispute resolution flow for organizers

---

### Story 6: Alerts & Notifications

**As a user, I receive useful alerts, not spam.**

#### Acceptance Criteria
- [ ] Toggle by notification type:
  - Push notifications
  - SMS
  - Email
- [ ] Notification triggers:
  - New match scheduled
  - Match reschedule
  - Result confirmed
  - Rain/closure at favorite court
  - Favorite court becomes busy
  - Ladder invitation
  - Match reminder (T-24h, T-3h)
- [ ] Time-zone aware delivery
- [ ] Quiet hours respected (default: 10 PM - 8 AM local time)
- [ ] Frequency limits (max 5 push/day for non-urgent)
- [ ] Rich notifications with action buttons

#### Technical Notes
- Firebase Cloud Messaging (Android)
- APNs (iOS)
- Twilio for SMS
- SendGrid/SES for email
- Notification preferences stored per user

---

### Story 7: Facility Verification ("Verified Courts")

**As a manager, I can verify and maintain court data.**

#### Acceptance Criteria
- [ ] Facility manager requests verification:
  - Submit proof (email domain, documentation)
  - Admin review process
  - Approval/rejection notification
- [ ] Verified facilities can:
  - Edit hours, fees, amenities
  - Post closure notifications
  - Add photos
  - Respond to user suggestions
- [ ] Changes visible immediately after save
- [ ] "Verified by PickleUp" badge displayed
- [ ] Closure notifications sent to users who favorited the court
- [ ] Verification badge visible on map pins and detail views

#### Technical Notes
- Admin dashboard for verification queue
- Audit log for all facility changes
- Image upload with compression
- Moderation queue for user suggestions

---

### Story 8: Onboarding

**As a new user, I start using PickleUp in under 60 seconds.**

#### Acceptance Criteria
- [ ] Sign in options:
  - Phone number + OTP
  - Email magic link
  - Social (Google/Apple)
- [ ] Location permission prompt with clear benefit copy:
  - "Find courts near you instantly"
- [ ] First-run flow:
  - Choose home area (map selection)
  - Select 2-3 favorite courts
  - Optional: Set skill level
  - Optional: Enable notifications
- [ ] Skip option available for each step
- [ ] Immediate access to map after location permission
- [ ] Tutorial tooltips on first use (dismissible)

#### Technical Notes
- Progressive onboarding (don't block usage)
- Analytics tracking for drop-off points
- A/B test different onboarding flows
- Guest mode for browsing without account

---

## 🚀 Post-MVP Ideas

### Phase 2 Features
- **Skill-Based Matching**: "Find partners 4.0–4.5 near me"
- **Weather Overlay**: Real-time weather + rain alerts
- **QR Check-In**: Scan code at verified courts for instant check-in
- **Mini-Tournaments**: Create and manage single-elimination brackets
- **Event Feeds**: Community events, clinics, and social play
- **Club Portal**: Premium accounts for clubs with advanced analytics

### Phase 3 Features
- **Video Highlights**: Upload and share match clips
- **Coaching Marketplace**: Connect with local coaches
- **Equipment Reviews**: Rate and review paddles, balls, gear
- **Social Features**: Follow players, comment on matches
- **Gamification**: Badges, achievements, streaks

---

## 🧪 QA Test Scenarios

### Critical Path Testing
1. **Location Permissions**
   - Granted on first launch
   - Denied → fallback to manual location
   - Revoked after initial grant

2. **Check-In Distance Validation**
   - Within 300m → success
   - Outside 300m → error message
   - GPS accuracy low → warning

3. **Match Scheduling Across Time-Zones**
   - Player A (PST) vs Player B (EST)
   - Calendar export shows correct local times
   - Reminders sent at correct local times

4. **Invite Flow**
   - SMS → OTP join → roster appears
   - Email → magic link → account creation
   - Expired link handling

5. **iCal Export**
   - Correct time zone
   - All match details included
   - Updates when match rescheduled

### Edge Cases
- Poor network connectivity
- Simultaneous result submissions
- Ladder with 1 player
- Court with 0 check-ins
- Notification permission denied
- Background location disabled

---

## 📊 Success Metrics by Story

| Story | Key Metric | Target (MVP) |
|-------|------------|--------------|
| Court Map | Time to first court view | < 3 seconds |
| Check-In | Daily check-ins per court | > 5 |
| Ladder Setup | Ladders created per week | > 10 |
| Match Scheduling | Match acceptance rate | > 80% |
| Results | Result confirmation time | < 24 hours |
| Notifications | Opt-out rate | < 15% |
| Verification | Verified courts | > 50 |
| Onboarding | Completion rate | > 70% |
