import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tic_tac_toe_game.dart';
import '../../../core/widgets/game_complete_overlay.dart';

class TicTacToeScreen extends StatelessWidget {
  const TicTacToeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TicTacToeGame(),
      child: const TicTacToeView(),
    );
  }
}

class TicTacToeView extends StatelessWidget {
  const TicTacToeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final game = context.watch<TicTacToeGame>();
    final size = MediaQuery.of(context).size;
    final boardSize = size.width > size.height 
        ? size.height * 0.6 
        : size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: game.resetGame,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.background,
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!game.gameOver) ...[
                  Text(
                    "Player ${game.currentPlayer.name}'s Turn",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                Center(
                  child: Container(
                    width: boardSize,
                    height: boardSize,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: theme.shadowColor.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        final row = index ~/ 3;
                        final col = index % 3;
                        final cell = game.board[row][col];
                        
                        return GestureDetector(
                          onTap: () => game.makeMove(row, col),
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: cell != Player.none
                                    ? Text(
                                        cell.name,
                                        key: ValueKey(cell),
                                        style: TextStyle(
                                          fontSize: boardSize * 0.1,
                                          fontWeight: FontWeight.bold,
                                          color: cell == Player.X
                                              ? theme.colorScheme.primary
                                              : theme.colorScheme.secondary,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (game.gameOver)
              GameCompleteOverlay(
                title: game.isDraw ? "It's a Draw!" : "Player ${game.winner?.name} Wins!",
                message: "Would you like to play another round?",
                onRestart: game.resetGame,
                accentColor: Colors.amber,
              ),
          ],
        ),
      ),
    );
  }
} 