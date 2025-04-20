import 'package:flutter/material.dart';
import '../models/game_module.dart';

class BaseGameWidget extends StatefulWidget {
  final GameModule gameModule;
  final Widget child;

  const BaseGameWidget({
    Key? key,
    required this.gameModule,
    required this.child,
  }) : super(key: key);

  @override
  State<BaseGameWidget> createState() => _BaseGameWidgetState();
}

class _BaseGameWidgetState extends State<BaseGameWidget> {
  bool _isPaused = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  Future<void> _initializeGame() async {
    await widget.gameModule.initialize();
    await widget.gameModule.loadState();
    setState(() {
      _isInitialized = true;
    });
  }

  Future<void> _togglePause() async {
    if (_isPaused) {
      await widget.gameModule.resume();
    } else {
      await widget.gameModule.pause();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  Future<void> _resetGame() async {
    await widget.gameModule.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameModule.name),
        actions: [
          IconButton(
            icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
            onPressed: _togglePause,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),
      body: Stack(
        children: [
          widget.child,
          if (_isPaused)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Text(
                  'PAUSED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.gameModule.saveState();
    super.dispose();
  }
} 