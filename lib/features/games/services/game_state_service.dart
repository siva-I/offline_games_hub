import 'package:shared_preferences.dart';
import '../models/game_module.dart';

class GameStateService {
  static const String _highScorePrefix = 'high_score_';
  static const String _gameStatePrefix = 'game_state_';

  final SharedPreferences _prefs;

  GameStateService(this._prefs);

  Future<int> getHighScore(String gameId) async {
    return _prefs.getInt('$_highScorePrefix$gameId') ?? 0;
  }

  Future<void> saveHighScore(String gameId, int score) async {
    final currentHighScore = await getHighScore(gameId);
    if (score > currentHighScore) {
      await _prefs.setInt('$_highScorePrefix$gameId', score);
    }
  }

  Future<String?> getGameState(String gameId) async {
    return _prefs.getString('$_gameStatePrefix$gameId');
  }

  Future<void> saveGameState(String gameId, String state) async {
    await _prefs.setString('$_gameStatePrefix$gameId', state);
  }

  Future<void> clearGameState(String gameId) async {
    await _prefs.remove('$_gameStatePrefix$gameId');
  }
} 