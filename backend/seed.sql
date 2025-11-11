-- Seed data for PickleUp - Clarion, PA area

-- Clear existing data
TRUNCATE TABLE court_checkins, user_favorites, courts, users CASCADE;

-- Create test users
INSERT INTO users (id, email, password_hash, name, skill_level, role, created_at, updated_at) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'john@example.com', '$2b$10$rKvK3qX.8Yh9bZ9Yx8qX8OqX8qX8qX8qX8qX8qX8qX8qX8qX8qX8q', 'John Doe', 4.0, 'PLAYER', NOW(), NOW()),
('550e8400-e29b-41d4-a716-446655440002', 'sarah@example.com', '$2b$10$rKvK3qX.8Yh9bZ9Yx8qX8OqX8qX8qX8qX8qX8qX8qX8qX8qX8qX8q', 'Sarah Miller', 3.5, 'PLAYER', NOW(), NOW());

-- Clarion, PA area courts
INSERT INTO courts (id, name, address, latitude, longitude, type, surface, has_lights, is_free, fee_amount, courts_count, description, amenities, verified, created_at, updated_at) VALUES
(gen_random_uuid(), 'Clarion University Recreation Center', '840 Wood St, Clarion, PA 16214', 41.2145, -79.3881, 'INDOOR', 'Hardwood', true, false, 5.00, 2, 'Indoor courts at Clarion University. Great for year-round play. Open to public with small fee.', ARRAY['Restrooms', 'Water Fountains', 'Parking'], true, NOW(), NOW()),
(gen_random_uuid(), 'Clarion County Park', 'Park Ave, Clarion, PA 16214', 41.2098, -79.3925, 'OUTDOOR', 'Asphalt', true, true, NULL, 4, 'Newly renovated outdoor courts in the heart of Clarion. Free to play, lights available until 10 PM.', ARRAY['Lights', 'Parking', 'Restrooms', 'Benches'], true, NOW(), NOW()),
(gen_random_uuid(), 'Immergrun Park Pickleball Courts', 'Immergrun Rd, Clarion, PA 16214', 41.2234, -79.3756, 'OUTDOOR', 'Concrete', false, true, NULL, 2, 'Quiet neighborhood courts. Perfect for morning and afternoon play.', ARRAY['Parking', 'Shade'], false, NOW(), NOW()),
(gen_random_uuid(), 'Clarion YMCA', '500 Greenville Ave, Clarion, PA 16214', 41.2167, -79.3892, 'INDOOR', 'Sport Court', true, false, 10.00, 2, 'YMCA membership required or day pass available. Climate-controlled indoor courts.', ARRAY['Locker Rooms', 'Showers', 'Parking', 'Pro Shop'], true, NOW(), NOW()),
(gen_random_uuid(), 'Brookville Recreation Park', 'Main St, Brookville, PA 15825', 41.1609, -79.0814, 'OUTDOOR', 'Asphalt', true, true, NULL, 3, 'About 20 miles from Clarion. Popular courts with active community.', ARRAY['Lights', 'Parking', 'Restrooms'], true, NOW(), NOW()),
(gen_random_uuid(), 'Shippenville Community Courts', 'Main St, Shippenville, PA 16254', 41.2567, -79.4628, 'OUTDOOR', 'Asphalt', false, true, NULL, 2, 'Small town courts, about 10 miles from Clarion. Well-maintained.', ARRAY['Parking'], false, NOW(), NOW()),
(gen_random_uuid(), 'Knox Community Park', 'South Main St, Knox, PA 16232', 41.2345, -79.5367, 'OUTDOOR', 'Concrete', true, true, NULL, 2, 'Newer courts in Knox, about 12 miles west of Clarion.', ARRAY['Lights', 'Parking', 'Playground'], false, NOW(), NOW()),
(gen_random_uuid(), 'Rimersburg Park Courts', 'Main St, Rimersburg, PA 16248', 41.0456, -79.5045, 'OUTDOOR', 'Asphalt', false, true, NULL, 2, 'Community courts in Rimersburg, about 15 miles south.', ARRAY['Parking', 'Benches'], false, NOW(), NOW());

-- Create sample check-ins at Clarion County Park
INSERT INTO court_checkins (id, court_id, user_id, start_at, end_at, duration_min, status, created_at)
SELECT 
  gen_random_uuid(),
  c.id,
  '550e8400-e29b-41d4-a716-446655440001',
  NOW(),
  NOW() + INTERVAL '2 hours',
  120,
  'ACTIVE',
  NOW()
FROM courts c
WHERE c.name = 'Clarion County Park'
LIMIT 1;

INSERT INTO court_checkins (id, court_id, user_id, start_at, end_at, duration_min, status, created_at)
SELECT 
  gen_random_uuid(),
  c.id,
  '550e8400-e29b-41d4-a716-446655440002',
  NOW(),
  NOW() + INTERVAL '90 minutes',
  90,
  'ACTIVE',
  NOW()
FROM courts c
WHERE c.name = 'Clarion County Park'
LIMIT 1;

SELECT 'Seed data created successfully!' as message;
SELECT COUNT(*) as court_count FROM courts;
SELECT COUNT(*) as user_count FROM users;
SELECT COUNT(*) as checkin_count FROM court_checkins;
