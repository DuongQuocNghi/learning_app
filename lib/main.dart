import 'package:flutter/material.dart';
import 'package:learning_app/game1/game_screen_1.dart';
import 'package:provider/provider.dart';
import 'game1/game_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
        title: 'Learning App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        home: GameScreen1(),
      ),
    );
  }
}
