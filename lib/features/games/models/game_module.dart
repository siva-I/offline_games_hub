import 'package:flutter/material.dart';

abstract class GameModule {
  /// Unique identifier for the game
  String get id;

  /// Display name of the game
  String get name;

  /// Description of the game
  String get description;

  /// Icon for the game
  IconData get icon;

  /// Widget that represents the game
  Widget get gameWidget;

  /// Initialize the game
  Future<void> initialize();

  /// Save the current game state
  Future<void> saveState();

  /// Load the saved game state
  Future<void> loadState();

  /// Reset the game to its initial state
  Future<void> reset();

  /// Pause the game
  Future<void> pause();

  /// Resume the game
  Future<void> resume();

  /// Get the current score
  int get score;

  /// Get the high score
  Future<int> getHighScore();

  /// Save the high score
  Future<void> saveHighScore(int score);
} 