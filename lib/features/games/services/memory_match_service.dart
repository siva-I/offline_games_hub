import '../models/memory_match_game.dart';

class MemoryMatchService {
  MemoryMatchGame handleCardFlip(
    MemoryMatchGame game,
    int cardIndex,
  ) {
    if (game.isGameOver ||
        game.cards[cardIndex].isMatched ||
        game.flippedIndices.contains(cardIndex)) {
      return game;
    }

    final newFlippedIndices = List<int>.from(game.flippedIndices)..add(cardIndex);
    var newMoves = game.moves;
    var newMatches = game.matches;
    var newCards = List<CardData>.from(game.cards);
    var isGameOver = game.isGameOver;

    if (newFlippedIndices.length == 2) {
      newMoves++;
      final firstCard = game.cards[newFlippedIndices[0]];
      final secondCard = game.cards[newFlippedIndices[1]];

      if (firstCard.value == secondCard.value) {
        newMatches++;
        newCards = newCards.map((card) {
          if (card.id == firstCard.id || card.id == secondCard.id) {
            return card.copyWith(isMatched: true);
          }
          return card;
        }).toList();

        if (newMatches == game.gridSize * game.gridSize ~/ 2) {
          isGameOver = true;
        }
      }
    }

    return game.copyWith(
      cards: newCards,
      moves: newMoves,
      matches: newMatches,
      flippedIndices: newFlippedIndices.length == 2 ? [] : newFlippedIndices,
      isGameOver: isGameOver,
    );
  }

  MemoryMatchGame resetGame(MemoryMatchGame game) {
    return MemoryMatchGame.initial(
      id: game.id,
      name: game.name,
      description: game.description,
      icon: game.icon,
      category: game.category,
      difficulty: game.difficulty,
      maxPlayers: game.maxPlayers,
      minAge: game.minAge,
      estimatedDuration: game.estimatedDuration,
      gridSize: game.gridSize,
    );
  }
} 