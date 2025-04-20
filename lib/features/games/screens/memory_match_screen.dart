import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/memory_match_provider.dart';
import '../models/memory_match_game.dart';
import '../models/base_game.dart';
import '../widgets/memory_match_card.dart';

class MemoryMatchScreen extends StatelessWidget {
  const MemoryMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = MemoryMatchProvider();
        provider.initializeGame(MemoryMatchGame.initial(
          id: 'memory_match',
          name: 'Memory Match',
          description: 'Match pairs of cards to win!',
          icon: Icons.memory,
          category: GameCategory.puzzle,
          difficulty: GameDifficulty.easy,
          maxPlayers: 1,
          minAge: 4,
          estimatedDuration: const Duration(minutes: 5),
          gridSize: 4,
        ));
        return provider;
      },
      child: const _MemoryMatchScreenContent(),
    );
  }
}

class _MemoryMatchScreenContent extends StatelessWidget {
  const _MemoryMatchScreenContent();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MemoryMatchProvider>();
    final game = provider.game;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: provider.resetGame,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Moves: ${provider.moves}'),
                Text('Matches: ${provider.matches}'),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: game.gridSize,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: game.cards.length,
              itemBuilder: (context, index) {
                return MemoryMatchCard(
                  card: game.cards[index],
                  isFlipped: provider.flippedIndices.contains(index),
                  onTap: () => provider.flipCard(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 