import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/snake_game.dart';
import '../../../core/widgets/game_complete_overlay.dart';
import 'dart:math';

class SnakeScreen extends StatefulWidget {
  const SnakeScreen({super.key});

  @override
  State<SnakeScreen> createState() => _SnakeScreenState();
}

class _SnakeScreenState extends State<SnakeScreen> {
  late final SnakeGame game;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    game = SnakeGame.initial();
    game.startGame();
  }

  @override
  void dispose() {
    game.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowUp:
          game.changeDirection(Direction.up);
          break;
        case LogicalKeyboardKey.arrowDown:
          game.changeDirection(Direction.down);
          break;
        case LogicalKeyboardKey.arrowLeft:
          game.changeDirection(Direction.left);
          break;
        case LogicalKeyboardKey.arrowRight:
          game.changeDirection(Direction.right);
          break;
        case LogicalKeyboardKey.space:
          if (game.isGameOver) {
            game.initializeGame();
            game.startGame();
          }
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              game.initializeGame();
              game.startGame();
            },
          ),
        ],
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        autofocus: true,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.stars,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Score',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 12,
                                  ),
                                ),
                                ListenableBuilder(
                                  listenable: game,
                                  builder: (context, _) {
                                    return Text(
                                      game.score.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ListenableBuilder(
                          listenable: game,
                          builder: (context, _) {
                            return CustomPaint(
                              painter: SnakeGamePainter(
                                snake: game.snake,
                                food: game.food,
                                gridSize: SnakeGame.gridSize,
                                primaryColor: Theme.of(context).colorScheme.primary,
                                secondaryColor: Theme.of(context).colorScheme.secondary,
                                nextPosition: game.nextPosition,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlButton(Icons.arrow_upward, () => game.changeDirection(Direction.up)),
                      _buildControlButton(Icons.arrow_downward, () => game.changeDirection(Direction.down)),
                      _buildControlButton(Icons.arrow_back, () => game.changeDirection(Direction.left)),
                      _buildControlButton(Icons.arrow_forward, () => game.changeDirection(Direction.right)),
                    ],
                  ),
                ),
              ],
            ),
            ListenableBuilder(
              listenable: game,
              builder: (context, _) {
                if (game.isGameOver) {
                  return GameCompleteOverlay(
                    title: 'Game Over!',
                    message: 'Final Score: ${game.score}',
                    onRestart: () {
                      game.initializeGame();
                      game.startGame();
                    },
                    accentColor: Theme.of(context).colorScheme.primary,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: 32,
    );
  }
}

class SnakeGamePainter extends CustomPainter {
  final List<Position> snake;
  final Position? food;
  final int gridSize;
  final Color primaryColor;
  final Color secondaryColor;
  final Position? nextPosition;

  SnakeGamePainter({
    required this.snake,
    required this.food,
    required this.gridSize,
    required this.primaryColor,
    required this.secondaryColor,
    this.nextPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / gridSize;
    final cellHeight = size.height / gridSize;

    // Draw grid lines
    final gridPaint = Paint()
      ..color = primaryColor.withOpacity(0.1)
      ..strokeWidth = 1;
    
    // Draw vertical lines
    for (int i = 0; i <= gridSize; i++) {
      canvas.drawLine(
        Offset(i * cellWidth, 0),
        Offset(i * cellWidth, size.height),
        gridPaint,
      );
    }
    
    // Draw horizontal lines
    for (int i = 0; i <= gridSize; i++) {
      canvas.drawLine(
        Offset(0, i * cellHeight),
        Offset(size.width, i * cellHeight),
        gridPaint,
      );
    }

    // Draw snake
    final paint = Paint()..color = primaryColor;
    for (final segment in snake) {
      canvas.drawRect(
        Rect.fromLTWH(
          segment.x * cellWidth,
          segment.y * cellHeight,
          cellWidth,
          cellHeight,
        ),
        paint,
      );
    }

    // Draw next position with a different color
    if (nextPosition != null) {
      final nextPaint = Paint()..color = primaryColor.withOpacity(0.5);
      canvas.drawRect(
        Rect.fromLTWH(
          nextPosition!.x * cellWidth,
          nextPosition!.y * cellHeight,
          cellWidth,
          cellHeight,
        ),
        nextPaint,
      );
    }

    // Draw food with a glowing effect
    if (food != null) {
      final foodPaint = Paint()
        ..color = secondaryColor
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(
        Offset(
          (food!.x * cellWidth) + (cellWidth / 2),
          (food!.y * cellHeight) + (cellHeight / 2),
        ),
        min(cellWidth, cellHeight) / 2,
        foodPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant SnakeGamePainter oldDelegate) {
    return snake != oldDelegate.snake || 
           food != oldDelegate.food || 
           nextPosition != oldDelegate.nextPosition;
  }
} 