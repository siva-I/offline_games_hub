import 'package:flutter/material.dart';
import '../models/memory_match_game.dart';

class MemoryMatchCard extends StatelessWidget {
  final CardData card;
  final bool isFlipped;
  final VoidCallback onTap;

  const MemoryMatchCard({
    super.key,
    required this.card,
    required this.isFlipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: card.isMatched ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: card.isMatched
              ? theme.colorScheme.primary.withOpacity(0.1)
              : isFlipped
                  ? theme.colorScheme.surface
                  : theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: isFlipped || card.isMatched
                ? Icon(
                    IconData(card.value, fontFamily: 'MaterialIcons'),
                    key: ValueKey(card.value),
                    size: 36.0,
                    color: card.isMatched
                        ? theme.colorScheme.primary.withOpacity(0.5)
                        : theme.colorScheme.primary,
                  )
                : const Icon(
                    Icons.question_mark,
                    key: ValueKey('question'),
                    size: 36.0,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
} 