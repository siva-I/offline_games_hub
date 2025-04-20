import 'package:flutter/material.dart';
import '../models/memory_match_game.dart';
import '../services/memory_match_service.dart';

class MemoryMatchProvider extends ChangeNotifier {
  final MemoryMatchService _service = MemoryMatchService();
  late MemoryMatchGame _game;

  MemoryMatchGame get game => _game;
  bool get isGameOver => _game.isGameOver;
  int get moves => _game.moves;
  int get matches => _game.matches;
  List<int> get flippedIndices => _game.flippedIndices;
  List<CardData> get cards => _game.cards;

  void initializeGame(MemoryMatchGame game) {
    _game = game;
    notifyListeners();
  }

  void flipCard(int cardIndex) {
    _game = _service.handleCardFlip(_game, cardIndex);
    notifyListeners();
  }

  void resetGame() {
    _game = _service.resetGame(_game);
    notifyListeners();
  }
} 