import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Seeding database...');

  // Create test users
  const hashedPassword = await bcrypt.hash('password123', 10);
  
  const user1 = await prisma.user.upsert({
    where: { email: 'john@example.com' },
    update: {},
    create: {
      email: 'john@example.com',
      passwordHash: hashedPassword,
      name: 'John Doe',
      skillLevel: 4.0,
      role: 'PLAYER',
    },
  });

  const user2 = await prisma.user.upsert({
    where: { email: 'sarah@example.com' },
    update: {},
    create: {
      email: 'sarah@example.com',
      passwordHash: hashedPassword,
      name: 'Sarah Miller',
      skillLevel: 3.5,
      role: 'PLAYER',
    },
  });

  console.log('✅ Created test users');

  // Clarion, PA area courts
  const courts = [
    {
      name: 'Clarion University Recreation Center',
      address: '840 Wood St, Clarion, PA 16214',
      latitude: 41.2145,
      longitude: -79.3881,
      type: 'INDOOR',
      surface: 'Hardwood',
      hasLights: true,
      isFree: false,
      feeAmount: 5.00,
      courtsCount: 2,
      description: 'Indoor courts at Clarion University. Great for year-round play. Open to public with small fee.',
      amenities: ['Restrooms', 'Water Fountains', 'Parking'],
      verified: true,
    },
    {
      name: 'Clarion County Park',
      address: 'Park Ave, Clarion, PA 16214',
      latitude: 41.2098,
      longitude: -79.3925,
      type: 'OUTDOOR',
      surface: 'Asphalt',
      hasLights: true,
      isFree: true,
      courtsCount: 4,
      description: 'Newly renovated outdoor courts in the heart of Clarion. Free to play, lights available until 10 PM.',
      amenities: ['Lights', 'Parking', 'Restrooms', 'Benches'],
      verified: true,
    },
    {
      name: 'Immergrun Park Pickleball Courts',
      address: 'Immergrun Rd, Clarion, PA 16214',
      latitude: 41.2234,
      longitude: -79.3756,
      type: 'OUTDOOR',
      surface: 'Concrete',
      hasLights: false,
      isFree: true,
      courtsCount: 2,
      description: 'Quiet neighborhood courts. Perfect for morning and afternoon play.',
      amenities: ['Parking', 'Shade'],
      verified: false,
    },
    {
      name: 'Clarion YMCA',
      address: '500 Greenville Ave, Clarion, PA 16214',
      latitude: 41.2167,
      longitude: -79.3892,
      type: 'INDOOR',
      surface: 'Sport Court',
      hasLights: true,
      isFree: false,
      feeAmount: 10.00,
      courtsCount: 2,
      description: 'YMCA membership required or day pass available. Climate-controlled indoor courts.',
      amenities: ['Locker Rooms', 'Showers', 'Parking', 'Pro Shop'],
      verified: true,
    },
    {
      name: 'Brookville Recreation Park',
      address: 'Main St, Brookville, PA 15825',
      latitude: 41.1609,
      longitude: -79.0814,
      type: 'OUTDOOR',
      surface: 'Asphalt',
      hasLights: true,
      isFree: true,
      courtsCount: 3,
      description: 'About 20 miles from Clarion. Popular courts with active community.',
      amenities: ['Lights', 'Parking', 'Restrooms'],
      verified: true,
    },
    {
      name: 'Shippenville Community Courts',
      address: 'Main St, Shippenville, PA 16254',
      latitude: 41.2567,
      longitude: -79.4628,
      type: 'OUTDOOR',
      surface: 'Asphalt',
      hasLights: false,
      isFree: true,
      courtsCount: 2,
      description: 'Small town courts, about 10 miles from Clarion. Well-maintained.',
      amenities: ['Parking'],
      verified: false,
    },
    {
      name: 'Knox Community Park',
      address: 'South Main St, Knox, PA 16232',
      latitude: 41.2345,
      longitude: -79.5367,
      type: 'OUTDOOR',
      surface: 'Concrete',
      hasLights: true,
      isFree: true,
      courtsCount: 2,
      description: 'Newer courts in Knox, about 12 miles west of Clarion.',
      amenities: ['Lights', 'Parking', 'Playground'],
      verified: false,
    },
    {
      name: 'Rimersburg Park Courts',
      address: 'Main St, Rimersburg, PA 16248',
      latitude: 41.0456,
      longitude: -79.5045,
      type: 'OUTDOOR',
      surface: 'Asphalt',
      hasLights: false,
      isFree: true,
      courtsCount: 2,
      description: 'Community courts in Rimersburg, about 15 miles south.',
      amenities: ['Parking', 'Benches'],
      verified: false,
    },
  ];

  // Delete existing courts first
  await prisma.court.deleteMany({});
  
  for (const court of courts) {
    await prisma.court.create({
      data: court as any,
    });
  }

  console.log(`✅ Created ${courts.length} courts in Clarion, PA area`);

  // Create some sample check-ins
  const clarionCountyPark = await prisma.court.findFirst({
    where: { name: 'Clarion County Park' },
  });

  if (clarionCountyPark) {
    await prisma.courtCheckin.create({
      data: {
        courtId: clarionCountyPark.id,
        userId: user1.id,
        startAt: new Date(),
        endAt: new Date(Date.now() + 2 * 60 * 60 * 1000), // 2 hours from now
        durationMin: 120,
        status: 'ACTIVE',
      },
    });

    await prisma.courtCheckin.create({
      data: {
        courtId: clarionCountyPark.id,
        userId: user2.id,
        startAt: new Date(),
        endAt: new Date(Date.now() + 90 * 60 * 1000), // 90 minutes from now
        durationMin: 90,
        status: 'ACTIVE',
      },
    });

    console.log('✅ Created sample check-ins');
  }

  console.log('🎉 Seeding complete!');
}

main()
  .catch((e) => {
    console.error('❌ Seeding failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
