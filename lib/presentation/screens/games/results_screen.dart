import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final int stars;
  final String gameId;

  const ResultsScreen({
    super.key,
    required this.score,
    required this.stars,
    required this.gameId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Results: Score $score, Stars $stars - TODO')),
    );
  }
}
