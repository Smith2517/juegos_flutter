import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  final String gameId;

  const GameScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Game Screen for $gameId - TODO')),
    );
  }
}
