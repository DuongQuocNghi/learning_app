import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learning_app/game_provider.dart';

class GameInput extends StatefulWidget {
  const GameInput({super.key});

  @override
  State<GameInput> createState() => GameInputState();
}

class GameInputState extends State<GameInput> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void focus() {
    _focusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmit(GameProvider gameProvider) {
    if (_textController.text.isNotEmpty) {
      gameProvider.submitAnswer(_textController.text);
      _textController.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      focusNode: _focusNode,
      autofocus: true,
      onSubmitted: (_) => _handleSubmit(context.read<GameProvider>()),
      decoration: InputDecoration(
        hintText: 'Nhập từ...',
        fillColor: Colors.white24,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
