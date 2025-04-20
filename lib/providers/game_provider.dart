import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/services/storage_service.dart';

class GameProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  bool _isInitialized = false;

  Future<void> init() async {
    if (!_isInitialized) {
      await _storageService.init();
      _isInitialized = true;
    }
  }

  Future<void> saveHighScore(String gameId, int score) async {
    await init();
    await _storageService.saveHighScore(gameId, score);
    notifyListeners();
  }

  Future<List<int>> getHighScores(String gameId) async {
    await init();
    return await _storageService.getHighScores(gameId);
  }

  Future<void> saveGameState(String gameId, String state) async {
    await init();
    await _storageService.saveGameState(gameId, state);
    notifyListeners();
  }

  Future<String?> getGameState(String gameId) async {
    await init();
    return await _storageService.getGameState(gameId);
  }

  Future<void> clearGameState(String gameId) async {
    await init();
    await _storageService.clearGameState(gameId);
    notifyListeners();
  }
} 