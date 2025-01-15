import 'package:flutter/material.dart';

class GameGuide extends StatelessWidget {
  const GameGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Text(
        'Dịch từ hiển thị sang ngôn ngữ được yêu cầu',
        style: TextStyle(color: Colors.blue),
        textAlign: TextAlign.center,
      ),
    );
  }
}
