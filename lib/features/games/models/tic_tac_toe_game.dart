import 'package:flutter/material.dart';

enum Player { X, O, none }

class TicTacToeGame extends ChangeNotifier {
  List<List<Player>> _board = List.generate(3, (_) => List.filled(3, Player.none));
  Player _currentPlayer = Player.X;
  bool _gameOver = false;
  Player? _winner;
  bool _isDraw = false;

  // Getters
  List<List<Player>> get board => _board;
  Player get currentPlayer => _currentPlayer;
  bool get gameOver => _gameOver;
  Player? get winner => _winner;
  bool get isDraw => _isDraw;

  void makeMove(int row, int col) {
    if (_board[row][col] != Player.none || _gameOver) return;

    _board[row][col] = _currentPlayer;
    _checkGameState(row, col);
    if (!_gameOver) {
      _currentPlayer = _currentPlayer == Player.X ? Player.O : Player.X;
    }
    notifyListeners();
  }

  void _checkGameState(int lastRow, int lastCol) {
    // Check row
    if (_board[lastRow].every((cell) => cell == _currentPlayer)) {
      _winner = _currentPlayer;
      _gameOver = true;
      return;
    }

    // Check column
    if (_board.every((row) => row[lastCol] == _currentPlayer)) {
      _winner = _currentPlayer;
      _gameOver = true;
      return;
    }

    // Check diagonals
    if (lastRow == lastCol) {
      if (_board.asMap().entries.every((entry) => 
          _board[entry.key][entry.key] == _currentPlayer)) {
        _winner = _currentPlayer;
        _gameOver = true;
        return;
      }
    }

    if (lastRow + lastCol == 2) {
      if (_board.asMap().entries.every((entry) => 
          _board[entry.key][2 - entry.key] == _currentPlayer)) {
        _winner = _currentPlayer;
        _gameOver = true;
        return;
      }
    }

    // Check for draw
    if (_board.every((row) => row.every((cell) => cell != Player.none))) {
      _isDraw = true;
      _gameOver = true;
      return;
    }
  }

  void resetGame() {
    _board = List.generate(3, (_) => List.filled(3, Player.none));
    _currentPlayer = Player.X;
    _gameOver = false;
    _winner = null;
    _isDraw = false;
    notifyListeners();
  }
} 