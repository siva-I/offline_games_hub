import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/memory_match_provider.dart';
import '../models/memory_match_game.dart';
import '../models/base_game.dart';
import '../widgets/memory_match_card.dart';
import '../../../core/widgets/game_complete_overlay.dart';

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
    final isGameComplete = provider.matches == (game.gridSize * game.gridSize) ~/ 2;

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
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ScoreCard(
                      icon: Icons.directions_run,
                      label: 'Moves',
                      value: provider.moves,
                      color: Colors.blue,
                    ),
                    _ScoreCard(
                      icon: Icons.check_circle,
                      label: 'Matches',
                      value: provider.matches,
                      color: Colors.green,
                    ),
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
          if (isGameComplete)
            GameCompleteOverlay(
              title: 'Congratulations!',
              message: 'You completed the game in ${provider.moves} moves!',
              onRestart: provider.resetGame,
              accentColor: Colors.amber,
            ),
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final Color color;

  const _ScoreCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                ),
              ),
              Text(
                value.toString(),
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 