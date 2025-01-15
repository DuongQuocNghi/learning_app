import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:learning_app/game1/models/word.dart';

class GameProvider extends ChangeNotifier {
  final List<Word> words = [];
  int score = 0;
  bool isGameOver = false;
  double baseSpeed = 50;
  DateTime? gameStartTime;
  Timer? _spawnTimer;

  final Map<String, String> wordPairs = {
    "home": "nhà",
    "cat": "mèo",
    "dog": "chó",
    "book": "sách",
    "computer": "máy tính",
    "water": "nước",
    "food": "thức ăn",
    "school": "trường học",
    "friend": "bạn",
    "teacher": "giáo viên",
    "table": "bàn",
    "chair": "ghế",
    "phone": "điện thoại",
    "car": "xe hơi",
    "house": "ngôi nhà"
  };

  void startGame() {
    words.clear();
    score = 0;
    isGameOver = false;
    gameStartTime = DateTime.now();
    _spawnTimer?.cancel();
    notifyListeners();
  }

  void submitAnswer(String input) {
    final lowerInput = input.toLowerCase().trim();
    for (var word in words.toList()) {
      if (lowerInput == word.requiredText.toLowerCase()) {
        words.remove(word);
        score += 10;
        notifyListeners();
        break;
      }
    }
  }

  void update(double screenWidth, double screenHeight, double delta) {
    if (isGameOver) return;

    bool needsUpdate = false;

    // Update existing words
    for (var word in words.toList()) {
      word.move(delta);
      if (word.y > screenHeight || word.timeLeft <= 0) {
        isGameOver = true;
        needsUpdate = true;
        break;
      }
      needsUpdate = true;
    }

    // Spawn new word with better timing
    if (!isGameOver && (words.isEmpty || words.last.y > 100)) {
      final entries = wordPairs.entries.toList();
      final randomEntry = entries[Random().nextInt(entries.length)];
      final currentSpeed = baseSpeed +
          (DateTime.now().difference(gameStartTime!).inSeconds * 1.5);

      words.add(Word(
        engText: randomEntry.key,
        vietText: randomEntry.value,
        speed: currentSpeed,
        screenWidth: screenWidth,
      ));
      needsUpdate = true;
    }

    if (needsUpdate) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _spawnTimer?.cancel();
    super.dispose();
  }
}
