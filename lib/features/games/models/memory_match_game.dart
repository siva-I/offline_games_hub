import 'package:flutter/material.dart';
import '../models/base_game.dart';

class MemoryMatchGame extends BaseGame {
  final List<CardData> cards;
  final int gridSize;
  final int moves;
  final int matches;
  final List<int> flippedIndices;
  final bool isGameOver;

  static const List<IconData> _gameIcons = [
    Icons.pets,
    Icons.emoji_emotions,
    Icons.favorite,
    Icons.star,
    Icons.local_pizza,
    Icons.local_cafe,
    Icons.music_note,
    Icons.sports_soccer,
    Icons.airplanemode_active,
    Icons.beach_access,
    Icons.cake,
    Icons.palette,
    Icons.camera,
    Icons.directions_bike,
    Icons.emoji_nature,
    Icons.spa,
  ];

  MemoryMatchGame({
    required super.id,
    required super.name,
    required super.description,
    required super.icon,
    required super.category,
    required super.difficulty,
    required super.maxPlayers,
    required super.minAge,
    required super.estimatedDuration,
    required this.cards,
    required this.gridSize,
    required this.moves,
    required this.matches,
    required this.flippedIndices,
    required this.isGameOver,
  });

  factory MemoryMatchGame.initial({
    required String id,
    required String name,
    required String description,
    required IconData icon,
    required GameCategory category,
    required GameDifficulty difficulty,
    required int maxPlayers,
    required int minAge,
    required Duration estimatedDuration,
    int gridSize = 4,
  }) {
    final totalCards = gridSize * gridSize;
    final pairs = totalCards ~/ 2;
    final selectedIcons = _gameIcons.take(pairs).toList();
    
    final cards = selectedIcons.expand((iconData) {
      return [
        CardData(id: '${iconData.codePoint}-1', value: iconData.codePoint, isMatched: false),
        CardData(id: '${iconData.codePoint}-2', value: iconData.codePoint, isMatched: false),
      ];
    }).toList()..shuffle();

    return MemoryMatchGame(
      id: id,
      name: name,
      description: description,
      icon: icon,
      category: category,
      difficulty: difficulty,
      maxPlayers: maxPlayers,
      minAge: minAge,
      estimatedDuration: estimatedDuration,
      cards: cards,
      gridSize: gridSize,
      moves: 0,
      matches: 0,
      flippedIndices: [],
      isGameOver: false,
    );
  }

  MemoryMatchGame copyWith({
    List<CardData>? cards,
    int? moves,
    int? matches,
    List<int>? flippedIndices,
    bool? isGameOver,
  }) {
    return MemoryMatchGame(
      id: id,
      name: name,
      description: description,
      icon: icon,
      category: category,
      difficulty: difficulty,
      maxPlayers: maxPlayers,
      minAge: minAge,
      estimatedDuration: estimatedDuration,
      cards: cards ?? this.cards,
      gridSize: gridSize,
      moves: moves ?? this.moves,
      matches: matches ?? this.matches,
      flippedIndices: flippedIndices ?? this.flippedIndices,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }
}

class CardData {
  final String id;
  final int value;
  final bool isMatched;

  const CardData({
    required this.id,
    required this.value,
    required this.isMatched,
  });

  CardData copyWith({
    bool? isMatched,
  }) {
    return CardData(
      id: id,
      value: value,
      isMatched: isMatched ?? this.isMatched,
    );
  }
} 