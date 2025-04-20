import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/games/models/game_module.dart';
import '../features/games/services/game_state_service.dart';

class GameProvider extends ChangeNotifier {
  final GameStateService _gameStateService;
  GameModule? _currentGame;
  bool _isPaused = false;

  GameProvider(this._gameStateService);

  GameModule? get currentGame => _currentGame;
  bool get isPaused => _isPaused;

  Future<void> setCurrentGame(GameModule game) async {
    _currentGame = game;
    await _currentGame?.initialize();
    await _currentGame?.loadState();
    notifyListeners();
  }

  Future<void> pauseGame() async {
    if (_currentGame != null) {
      await _currentGame!.pause();
      _isPaused = true;
      notifyListeners();
    }
  }

  Future<void> resumeGame() async {
    if (_currentGame != null) {
      await _currentGame!.resume();
      _isPaused = false;
      notifyListeners();
    }
  }

  Future<void> resetGame() async {
    if (_currentGame != null) {
      await _currentGame!.reset();
      notifyListeners();
    }
  }

  Future<void> saveGameState() async {
    if (_currentGame != null) {
      await _currentGame!.saveState();
    }
  }

  Future<void> updateScore(int score) async {
    if (_currentGame != null) {
      await _gameStateService.saveHighScore(_currentGame!.id, score);
      notifyListeners();
    }
  }
} 