import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _highScoresKey = 'high_scores';
  static const String _gameStateKey = 'game_state_';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // High Scores
  Future<void> saveHighScore(String gameId, int score) async {
    final scores = await getHighScores(gameId);
    scores.add(score);
    scores.sort((a, b) => b.compareTo(a)); // Sort in descending order
    if (scores.length > 10) scores.removeLast(); // Keep only top 10 scores
    await _prefs.setStringList('$_highScoresKey$gameId', scores.map((e) => e.toString()).toList());
  }

  Future<List<int>> getHighScores(String gameId) async {
    final scores = _prefs.getStringList('$_highScoresKey$gameId') ?? [];
    return scores.map((e) => int.parse(e)).toList();
  }

  // Game State
  Future<void> saveGameState(String gameId, String state) async {
    await _prefs.setString('$_gameStateKey$gameId', state);
  }

  Future<String?> getGameState(String gameId) async {
    return _prefs.getString('$_gameStateKey$gameId');
  }

  Future<void> clearGameState(String gameId) async {
    await _prefs.remove('$_gameStateKey$gameId');
  }
} 