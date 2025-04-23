import 'package:flutter/material.dart';
import '../models/game.dart';

class GameTile extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;

  const GameTile({
    super.key,
    required this.game,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getGameIcon(game.id),
                size: 48,
                color: isDark 
                  ? theme.colorScheme.secondary 
                  : theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                game.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark 
                    ? theme.colorScheme.onSurface 
                    : theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                game.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark 
                    ? theme.colorScheme.onSurface.withOpacity(0.8) 
                    : theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getGameIcon(String gameId) {
    switch (gameId) {
      case 'memory_match':
        return Icons.grid_view;
      case 'snake':
        return Icons.gesture;
      case 'tic_tac_toe':
        return Icons.grid_3x3;
      case 'puzzle':
        return Icons.extension;
      default:
        return Icons.sports_esports;
    }
  }
} 