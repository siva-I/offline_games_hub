import 'package:flutter/material.dart';

enum GameCategory {
  puzzle,
  action,
  strategy,
  arcade,
  card,
}

enum GameDifficulty {
  easy,
  medium,
  hard,
}

abstract class BaseGame {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final GameCategory category;
  final GameDifficulty difficulty;
  final int maxPlayers;
  final int minAge;
  final Duration estimatedDuration;

  const BaseGame({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    required this.difficulty,
    required this.maxPlayers,
    required this.minAge,
    required this.estimatedDuration,
  });
} 