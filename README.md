# 🎮 Offline Games Hub

A Flutter-based mobile application that serves as a container for multiple offline playable minigames. The app is designed to work fully without internet access and allows users to enjoy classic and casual games through a single, easy-to-navigate interface.

## 🚀 Features

- Multiple offline playable games
- Clean and modern UI
- Dark mode support
- Local score tracking
- No internet required
- Cross-platform support

## 🛠️ Tech Stack

- Flutter SDK (^3.7.2)
- Dart SDK
- Provider for state management
- Shared Preferences for local storage
- Google Fonts for typography
- Flutter Launcher Icons for app icons

## 📱 Supported Platforms

- Android
- iOS (coming soon)
- Web (coming soon)

## 🏗️ Project Structure

```
lib/
├── core/          # Core functionality and utilities
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── features/      # Feature-specific code
│   ├── games/
│   ├── home/
│   └── settings/
├── models/        # Data models
├── providers/     # State management
└── services/      # Business logic and services
```

## 🚦 Getting Started

1. **Prerequisites**
   - Flutter SDK
   - Dart SDK
   - Android Studio / VS Code
   - Git

2. **Installation**
   ```bash
   # Clone the repository
   git clone [repository-url]

   # Navigate to project directory
   cd offline_games_hub

   # Install dependencies
   flutter pub get

   # Run the app
   flutter run
   ```

## 🧪 Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/[test_file_name].dart
```

## 📝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
