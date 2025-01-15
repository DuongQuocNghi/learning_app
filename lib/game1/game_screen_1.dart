import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learning_app/game1/game_provider.dart';
import 'package:learning_app/game1/widgets/game_guide.dart';
import 'package:learning_app/game1/widgets/game_input.dart';
import 'package:learning_app/game1/widgets/score_display.dart';
import 'package:learning_app/game1/widgets/word_widget.dart';

class GameScreen1 extends StatefulWidget {
  const GameScreen1({super.key});

  @override
  State<GameScreen1> createState() => _GameScreen1State();
}

class _GameScreen1State extends State<GameScreen1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  DateTime? lastUpdate;
  final GlobalKey<GameInputState> _gameInputKey = GlobalKey<GameInputState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller.addListener(_onAnimationUpdate);
    _controller.repeat(period: const Duration(milliseconds: 16));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().startGame();
    });
  }

  void _onAnimationUpdate() {
    if (!mounted) return;

    final now = DateTime.now();
    if (lastUpdate == null) {
      lastUpdate = now;
      return;
    }

    final delta = now.difference(lastUpdate!).inMilliseconds / 1000;
    lastUpdate = now;

    final size = MediaQuery.of(context).size;
    context.read<GameProvider>().update(size.width, size.height, delta);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          if (gameProvider.isGameOver) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Game Over!\nĐiểm số: ${gameProvider.score}',
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      gameProvider.startGame();
                      _gameInputKey.currentState?.focus();
                    },
                    child: const Text('Chơi lại'),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              // Words layer
              for (final word in gameProvider.words)
                WordWidget(word: word),

              // Score and guide - wrapped in const widgets where possible
              const GameGuide(),

              ScoreDisplay(score: gameProvider.score),

              // Input layer with const constructor
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: GameInput(key: _gameInputKey),
              ),
            ],
          );
        },
      ),
    );
  }
}
