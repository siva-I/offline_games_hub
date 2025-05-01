import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'base_game.dart';

enum Direction { up, down, left, right }

class Position {
  final int x;
  final int y;

  const Position(this.x, this.y);

  Position translate(Direction direction) {
    switch (direction) {
      case Direction.up:
        return Position(x, y - 1);
      case Direction.down:
        return Position(x, y + 1);
      case Direction.left:
        return Position(x - 1, y);
      case Direction.right:
        return Position(x + 1, y);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class SnakeGame extends ChangeNotifier implements BaseGame {
  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final IconData icon;
  @override
  final GameCategory category;
  @override
  final GameDifficulty difficulty;
  @override
  final int maxPlayers;
  @override
  final int minAge;
  @override
  final Duration estimatedDuration;

  static const int gridSize = 15; // Reduced grid size for more square appearance
  static const initialSpeed = 400; // Slower initial speed for better control
  
  List<Position> snake = [];
  Position? food;
  Direction direction = Direction.right;
  bool isGameOver = false;
  Timer? gameTimer;
  int score = 0;
  int speed = initialSpeed;
  Position? nextPosition; // Store the next position for animation

  SnakeGame({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    required this.difficulty,
    required this.maxPlayers,
    required this.minAge,
    required this.estimatedDuration,
  }) {
    initializeGame();
  }

  factory SnakeGame.initial() {
    return SnakeGame(
      id: 'snake',
      name: 'Snake',
      description: 'Classic snake game - eat food and grow longer!',
      icon: Icons.sports_esports,
      category: GameCategory.arcade,
      difficulty: GameDifficulty.medium,
      maxPlayers: 1,
      minAge: 5,
      estimatedDuration: const Duration(minutes: 5),
    );
  }

  void initializeGame() {
    // Initialize snake at the center
    final centerX = gridSize ~/ 2;
    final centerY = gridSize ~/ 2;
    snake = [Position(centerX, centerY)];
    direction = Direction.right;
    isGameOver = false;
    score = 0;
    speed = initialSpeed;
    spawnFood();
    notifyListeners();
  }

  void spawnFood() {
    final random = Random();
    Position newFood;
    do {
      newFood = Position(
        random.nextInt(gridSize),
        random.nextInt(gridSize),
      );
    } while (snake.contains(newFood));
    food = newFood;
  }

  void startGame() {
    if (gameTimer != null) return;
    
    gameTimer = Timer.periodic(Duration(milliseconds: speed), (timer) {
      if (!isGameOver) {
        moveSnake();
      } else {
        timer.cancel();
        gameTimer = null;
      }
    });
  }

  void pauseGame() {
    gameTimer?.cancel();
    gameTimer = null;
    notifyListeners();
  }

  void changeDirection(Direction newDirection) {
    // Prevent 180-degree turns
    if ((direction == Direction.up && newDirection == Direction.down) ||
        (direction == Direction.down && newDirection == Direction.up) ||
        (direction == Direction.left && newDirection == Direction.right) ||
        (direction == Direction.right && newDirection == Direction.left)) {
      return;
    }
    direction = newDirection;
  }

  void moveSnake() {
    if (isGameOver) return;

    final head = snake.first;
    final newHead = head.translate(direction);

    // Check for wall collision
    if (newHead.x < 0 || newHead.x >= gridSize || newHead.y < 0 || newHead.y >= gridSize) {
      gameOver();
      return;
    }

    // Check for self collision (excluding the tail since it will move)
    for (int i = 0; i < snake.length - 1; i++) {
      if (snake[i] == newHead) {
        gameOver();
        return;
      }
    }

    nextPosition = newHead;
    snake.insert(0, newHead);

    // Check if food is eaten
    if (snake.first == food) {
      score += 10;
      spawnFood();
      // Increase speed every 50 points, but more gradually
      if (score % 50 == 0) {
        speed = max(200, speed - 10); // Slower speed increase
        restartTimer();
      }
    } else {
      snake.removeLast();
    }

    notifyListeners();
  }

  void restartTimer() {
    gameTimer?.cancel();
    gameTimer = Timer.periodic(Duration(milliseconds: speed), (timer) {
      if (!isGameOver) {
        moveSnake();
      } else {
        timer.cancel();
        gameTimer = null;
      }
    });
  }

  void gameOver() {
    isGameOver = true;
    gameTimer?.cancel();
    gameTimer = null;
    notifyListeners();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }
} 