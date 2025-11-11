# 🎾 PickleUp

**Find a Court. Pick Up a Match.**

PickleUp is the go-to mobile app for discovering nearby pickleball courts, checking real-time crowd levels, and organizing ladders or leagues with minimal friction. Built for iOS and Android.

![Version](https://img.shields.io/badge/version-0.1.0--alpha-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## 🚀 Vision

Be the fastest way to "pick up" a match — find courts, know how busy they are, and keep ladders running smoothly.

## ✨ Key Features

### 🗺️ Court Discovery
- **Interactive Map**: Instantly see nearby pickleball courts on an intuitive map interface
- **Real-Time Crowding**: Live occupancy levels (Light/Moderate/Busy) based on player check-ins
- **Smart Filters**: Find exactly what you need - Open Now, Free Courts, Lights On, Indoor Only
- **Detailed Info**: Court surface, amenities, hours, fees, and verified facility badges

### 🪜 Ladder Management
- **AutoServe Scheduling**: Automatic match generation based on player availability and rankings
- **Easy Results**: Quick score entry with opponent confirmation
- **Live Standings**: Real-time ladder rankings with color-coded positions
- **Smart Notifications**: Push, SMS, and email alerts for matches, results, and court updates

### ✅ Facility Verification
- **Verified Courts**: Facility managers can claim and maintain accurate court information
- **Community Updates**: Players can suggest edits for crowdsourced accuracy
- **Closure Alerts**: Instant notifications when favorite courts close or change hours

## 👥 Built For

- **Casual Players**: Find open courts quickly and see how busy they are
- **Organizers**: Run community ladders with automated scheduling and standings
- **Facility Managers**: Maintain accurate court data and communicate with players

## 📱 Tech Stack

- **Mobile**: Flutter (Dart) or React Native
- **Backend**: Node.js + TypeScript (Fastify/NestJS)
- **Database**: PostgreSQL + PostGIS
- **Authentication**: Auth0 / AWS Cognito
- **Push & SMS**: Firebase Cloud Messaging / APNs + Twilio
- **Maps**: Google Maps SDK / Apple MapKit
- **Hosting**: AWS or Render with Docker

## 📂 Repository Structure

```
pickle-up/
├── docs/               # Comprehensive documentation
│   ├── ARCHITECTURE.md # System architecture & design
│   ├── API.md         # API specifications
│   ├── DATA_MODEL.md  # Database schema & relationships
│   └── USER_STORIES.md # Detailed user stories & acceptance criteria
├── mobile/            # Mobile app (Flutter/React Native)
├── backend/           # Backend API services
├── infrastructure/    # Infrastructure as code
└── README.md          # This file
```

## 🎯 MVP Roadmap

| Milestone | Focus | Timeline |
|-----------|-------|----------|
| **M1** | Map + Court Data + Check-ins | Weeks 1-3 |
| **M2** | Ladder Creation + Invites + Scheduling | Weeks 4-6 |
| **M3** | Results + Standings + Verification | Weeks 7-8 |
| **M4** | Polish + Analytics + Beta Launch | Week 9 |

## 🚦 Getting Started

### Prerequisites
- Node.js 18+ (for backend)
- Flutter 3.x / React Native 0.72+ (for mobile)
- PostgreSQL 14+ with PostGIS extension
- Docker (optional, for containerized development)

### Quick Start

```bash
# Clone the repository
git clone https://github.com/rudesyle/pickle-up.git
cd pickle-up

# Backend setup
cd backend
npm install
cp .env.example .env
npm run dev

# Mobile setup
cd ../mobile
flutter pub get  # or: npm install (for React Native)
flutter run      # or: npm run ios/android
```

## 📊 Key Metrics

- **DAU/MAU**: Daily and monthly active users
- **Check-ins per day**: Court activity tracking
- **New ladders created**: Community growth
- **Match confirmation time**: User engagement
- **Retention**: D1/D7/D30 cohort analysis

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

**Maintainer**: rudesyle@gmail.com

## 🙏 Acknowledgments

Built with ❤️ for the pickleball community.

---

**Status**: 🚧 In Development | **Version**: 0.1.0-alpha | **Last Updated**: November 2025
