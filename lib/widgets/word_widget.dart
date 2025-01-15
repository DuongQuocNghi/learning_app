import 'package:flutter/material.dart';
import 'package:learning_app/models/word.dart';

class WordWidget extends StatelessWidget {
  final Word word;

  const WordWidget({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: word.x,
      top: word.y,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${word.timeLeft.toStringAsFixed(1)}',
            style: const TextStyle(color: Colors.red),
          ),
          Row(
            children: [
              Text(
                word.displayedText,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                word.showEnglish ? '→ Tiếng Việt' : '→ Tiếng Anh',
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
