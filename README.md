# 🎮 Offline Games Hub

A Flutter-based mobile application that serves as a container for multiple offline playable minigames. The app is designed to work fully without internet access and allows users to enjoy classic and casual games through a single, easy-to-navigate interface.

## 🎯 Available Games

### 1. Memory Match
- 4x4 grid of cards with beautiful Material icons
- Smooth card flipping animations
- Score tracking (moves and matches)
- Theme-aware design that works in both light and dark mode
- Game completion detection with celebration overlay
- Reset functionality

### 2. Tic Tac Toe
- Classic 3x3 grid gameplay
- Two-player X and O turns
- Win and draw detection
- Theme-aware design that works in both light and dark mode
- Game completion detection with celebration overlay
- Reset functionality

### 3. Snake
- Classic snake gameplay with modern UI
- Keyboard and touch controls
- Progressive difficulty (snake speeds up as you score)
- Score tracking
- Theme-aware design that works in both light and dark mode
- Game completion detection with celebration overlay
- Reset functionality

## 🚀 Features

- Multiple offline playable games
- Clean and modern UI
- Dark mode support
- Local score tracking
- No internet required
- Cross-platform support
- Smooth animations
- Theme-aware design
- Reusable game components:
  - Victory celebration overlay
  - Score tracking widgets
  - Game reset functionality

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
│   └── widgets/   # Reusable widgets (GameCompleteOverlay, etc.)
├── features/      # Feature-specific code
│   ├── games/     # Game modules
│   │   ├── models/
│   │   ├── providers/
│   │   ├── screens/
│   │   ├── services/
│   │   └── widgets/
│   ├── home/      # Home screen
│   └── settings/  # Settings screen
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

## 🎮 How to Play

1. **Memory Match**
   - Tap on any card to flip it
   - Try to find matching pairs of icons
   - The game tracks your moves and matches
   - Complete the game by finding all pairs
   - Celebration overlay appears on victory
   - Use the refresh button to start a new game

2. **Tic Tac Toe**
   - Players take turns placing X and O
   - Get three in a row to win
   - Game detects wins and draws
   - Celebration overlay appears on victory
   - Use the refresh button to start a new game

3. **Snake**
   - Control the snake using arrow keys or on-screen buttons
   - Eat food to grow longer and increase your score
   - Avoid hitting walls and yourself
   - Snake speeds up every 50 points
   - Game over when you hit a wall or yourself
   - Use the refresh button or space bar to start a new game

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

## 🎯 Upcoming Features

1. More games in the collection
2. High score system
3. Sound effects and background music
4. User profiles
5. Game statistics and achievements
