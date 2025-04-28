import 'package:flutter/material.dart';
import 'dart:math' as math;

class PaintByNumbersProvider extends ChangeNotifier {
  static const defaultColors = [
    Colors.yellow,      // 1: Sun
    Colors.orange,      // 2: Sun rays
    Colors.lightBlue,   // 3: Sky
    Colors.green,       // 4: Grass
    Colors.brown,       // 5: Tree trunk
    Colors.lightGreen,  // 6: Tree leaves
    Colors.red,         // 7: House
    Colors.grey,        // 8: Roof
    Colors.white,       // 9: Windows
    Colors.blue,        // 10: Door
  ];

  Color _selectedColor = defaultColors[0];
  int _selectedNumber = 1;
  final List<List<int>> _numberGrid = [];
  final List<List<Color>> _colorGrid = [];
  bool _isPainting = false;

  Color get selectedColor => _selectedColor;
  int get selectedNumber => _selectedNumber;
  List<List<int>> get numberGrid => _numberGrid;
  List<List<Color>> get colorGrid => _colorGrid;
  bool get isPainting => _isPainting;

  PaintByNumbersProvider() {
    _initializeGrid();
  }

  void _initializeGrid() {
    // Create a 30x30 grid for more detail
    for (int i = 0; i < 30; i++) {
      _numberGrid.add(List.generate(30, (j) => 0));
      _colorGrid.add(List.generate(30, (j) => Colors.white));
    }

    // Generate a landscape scene
    _generateLandscape();
  }

  void _generateLandscape() {
    // Draw the sky (number 3)
    for (int i = 0; i < 15; i++) {
      for (int j = 0; j < 30; j++) {
        _numberGrid[i][j] = 3;
      }
    }

    // Draw the sun (number 1)
    final sunX = 5;
    final sunY = 5;
    for (int i = -2; i <= 2; i++) {
      for (int j = -2; j <= 2; j++) {
        if (i * i + j * j <= 4) {
          _numberGrid[sunY + i][sunX + j] = 1;
        }
      }
    }

    // Draw sun rays (number 2)
    for (int i = 0; i < 8; i++) {
      final angle = i * (math.pi / 4);
      final x = (4 * math.cos(angle)).round();
      final y = (4 * math.sin(angle)).round();
      for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
          if (dx * dx + dy * dy <= 1) {
            final ny = sunY + y + dy;
            final nx = sunX + x + dx;
            if (nx >= 0 && nx < 30 && ny >= 0 && ny < 15) {
              _numberGrid[ny][nx] = 2;
            }
          }
        }
      }
    }

    // Draw the grass (number 4)
    for (int i = 15; i < 30; i++) {
      for (int j = 0; j < 30; j++) {
        _numberGrid[i][j] = 4;
      }
    }

    // Draw the house (number 7)
    for (int i = 17; i < 23; i++) {
      for (int j = 5; j < 15; j++) {
        _numberGrid[i][j] = 7;
      }
    }

    // Draw the roof (number 8)
    for (int i = 16; i < 17; i++) {
      for (int j = 4; j < 16; j++) {
        _numberGrid[i][j] = 8;
      }
    }

    // Draw the windows (number 9)
    _numberGrid[19][7] = 9;
    _numberGrid[19][13] = 9;
    _numberGrid[21][7] = 9;
    _numberGrid[21][13] = 9;

    // Draw the door (number 10)
    for (int i = 20; i < 23; i++) {
      for (int j = 9; j < 11; j++) {
        _numberGrid[i][j] = 10;
      }
    }

    // Draw the tree trunk (number 5)
    for (int i = 17; i < 25; i++) {
      for (int j = 20; j < 22; j++) {
        _numberGrid[i][j] = 5;
      }
    }

    // Draw the tree leaves (number 6)
    for (int i = 15; i < 20; i++) {
      for (int j = 18; j < 24; j++) {
        if ((i - 17) * (i - 17) + (j - 21) * (j - 21) <= 9) {
          _numberGrid[i][j] = 6;
        }
      }
    }
  }

  void selectColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  void selectNumber(int number) {
    if (number >= 1 && number <= 10) {
      _selectedNumber = number;
      _selectedColor = defaultColors[number - 1];
      notifyListeners();
    }
  }

  void startPainting() {
    _isPainting = true;
    notifyListeners();
  }

  void stopPainting() {
    _isPainting = false;
    notifyListeners();
  }

  void paintCell(int row, int col) {
    if (row >= 0 && row < _colorGrid.length && 
        col >= 0 && col < _colorGrid[0].length &&
        _numberGrid[row][col] == _selectedNumber) {
      _colorGrid[row][col] = _selectedColor;
      notifyListeners();
    }
  }

  void resetCanvas() {
    for (int i = 0; i < _colorGrid.length; i++) {
      for (int j = 0; j < _colorGrid[i].length; j++) {
        _colorGrid[i][j] = Colors.white;
      }
    }
    notifyListeners();
  }
} 