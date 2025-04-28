import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/paint_by_numbers_provider.dart';

class NumberGrid extends StatelessWidget {
  const NumberGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaintByNumbersProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Text(
                'Paint by Numbers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final number = index + 1;
                    final isSelected = provider.selectedNumber == number;
                    final color = PaintByNumbersProvider.defaultColors[number - 1];
                    String label = '';
                    switch (number) {
                      case 1:
                        label = 'Sun';
                        break;
                      case 2:
                        label = 'Sun Rays';
                        break;
                      case 3:
                        label = 'Sky';
                        break;
                      case 4:
                        label = 'Grass';
                        break;
                      case 5:
                        label = 'Tree Trunk';
                        break;
                      case 6:
                        label = 'Tree Leaves';
                        break;
                      case 7:
                        label = 'House';
                        break;
                      case 8:
                        label = 'Roof';
                        break;
                      case 9:
                        label = 'Windows';
                        break;
                      case 10:
                        label = 'Door';
                        break;
                    }
                    return GestureDetector(
                      onTap: () => provider.selectNumber(number),
                      child: Container(
                        decoration: BoxDecoration(
                          color: color.withOpacity(isSelected ? 1.0 : 0.7),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.grey,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  number.toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.black : Colors.grey.shade800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? Colors.black : Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 