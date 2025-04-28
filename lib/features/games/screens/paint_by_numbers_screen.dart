import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/paint_by_numbers_provider.dart';
import '../widgets/paint_canvas.dart';
import '../widgets/number_grid.dart';

class PaintByNumbersScreen extends StatelessWidget {
  const PaintByNumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaintByNumbersProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Paint by Numbers'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<PaintByNumbersProvider>().resetCanvas();
              },
            ),
          ],
        ),
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: PaintCanvas(),
            ),
            Expanded(
              flex: 1,
              child: NumberGrid(),
            ),
          ],
        ),
      ),
    );
  }
} 