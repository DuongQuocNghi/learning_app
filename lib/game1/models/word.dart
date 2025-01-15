import 'dart:math';

class Word {
  final String engText;
  final String vietText;
  final bool showEnglish;
  double x;
  double y;
  final double speed;
  double timeLeft;
  final DateTime startTime;

  String get displayedText => showEnglish ? engText : vietText;
  String get requiredText => showEnglish ? vietText : engText;

  Word({
    required this.engText,
    required this.vietText,
    required this.speed,
    required double screenWidth,
  })  : showEnglish = Random().nextBool(),
        x = Random().nextDouble() * (screenWidth - 200),
        y = 0,
        timeLeft = 12,
        startTime = DateTime.now();

  void move(double delta) {
    y += speed * delta;
    final elapsedSeconds = DateTime.now().difference(startTime).inMilliseconds / 1000;
    timeLeft = max(0, 12 - elapsedSeconds);
  }
}
