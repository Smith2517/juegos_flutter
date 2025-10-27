library;

/// Multiplicación Espacial - Juego de multiplicación para niños de 8-10 años
///
/// Este juego presenta problemas de multiplicación con representación visual
/// usando emojis espaciales en grupos (arrays).
///
/// Características:
/// - Multiplicación mostrada como grupos de objetos
/// - Emojis espaciales temáticos
/// - Sistema de puntuación con bonos y penalizaciones
/// - Dificultad adaptativa (tablas del 2 al 10)
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/theme/colors.dart';

class MultiplicacionEspacialGame extends StatefulWidget {
  const MultiplicacionEspacialGame({super.key});

  @override
  State<MultiplicacionEspacialGame> createState() => _MultiplicacionEspacialGameState();
}

class _MultiplicacionEspacialGameState extends State<MultiplicacionEspacialGame> {
  final Random _random = Random();

  int _currentScore = 0;
  int _questionsAnswered = 0;
  int _correctAnswers = 0;
  int _consecutiveCorrect = 0;

  int _num1 = 0; // Número de grupos
  int _num2 = 0; // Objetos por grupo
  int _correctAnswer = 0;
  List<int> _options = [];
  String _currentEmoji = '🚀';

  final List<String> _emojis = [
    '🚀', '🛸', '🌟', '⭐', '💫', '🌙', '🪐', '🌍',
    '👽', '🛰️', '☄️', '🌠', '🔭', '🧑‍🚀'
  ];

  Timer? _gameTimer;
  int _timeRemaining = 60;

  bool _showFeedback = false;
  bool _isCorrect = false;
  int? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _generateNewProblem();
    _startTimer();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _endGame();
        }
      });
    });
  }

  void _generateNewProblem() {
    setState(() {
      // Empezar con tablas fáciles (2-5) y aumentar gradualmente
      int maxTable = 2 + (_correctAnswers ~/ 2).clamp(0, 8); // Hasta tabla del 10

      _num1 = _random.nextInt(maxTable) + 2; // De 2 a maxTable
      _num2 = _random.nextInt(5) + 2; // De 2 a 6

      _correctAnswer = _num1 * _num2;

      _currentEmoji = _emojis[_random.nextInt(_emojis.length)];
      _options = _generateOptions(_correctAnswer);
      _options.shuffle();

      _showFeedback = false;
      _selectedAnswer = null;
    });
  }

  List<int> _generateOptions(int correct) {
    List<int> options = [correct];

    while (options.length < 4) {
      int offset = _random.nextInt(7) - 3;
      if (offset == 0) offset = _random.nextBool() ? 4 : -4;

      int wrongAnswer = correct + offset;
      if (wrongAnswer > 0 && !options.contains(wrongAnswer)) {
        options.add(wrongAnswer);
      }
    }

    return options;
  }

  void _checkAnswer(int selectedAnswer) {
    if (_showFeedback) return;

    setState(() {
      _selectedAnswer = selectedAnswer;
      _isCorrect = selectedAnswer == _correctAnswer;
      _showFeedback = true;
      _questionsAnswered++;

      if (_isCorrect) {
        _correctAnswers++;
        _consecutiveCorrect++;

        int basePoints = 15; // Más puntos por multiplicación
        int timeBonus = (_timeRemaining / 10).floor() * 3;
        int streakBonus = (_consecutiveCorrect > 1) ? (_consecutiveCorrect - 1) * 7 : 0;

        _currentScore += basePoints + timeBonus + streakBonus;
      } else {
        _consecutiveCorrect = 0;
        _currentScore = (_currentScore - 7).clamp(0, double.infinity).toInt();
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _generateNewProblem();
      }
    });
  }

  void _endGame() {
    _gameTimer?.cancel();

    context.push('/game-results', extra: {
      'gameId': 'multiplicacion_espacial',
      'gameName': 'Multiplicación Espacial',
      'score': _currentScore,
      'questionsAnswered': _questionsAnswered,
      'correctAnswers': _correctAnswers,
      'accuracy': _questionsAnswered > 0
          ? ((_correctAnswers / _questionsAnswered) * 100).round()
          : 0,
    });
  }

  Color _getOptionColor(int option) {
    if (!_showFeedback) return Colors.white;
    if (option == _selectedAnswer) {
      return _isCorrect ? Colors.green.shade100 : Colors.red.shade100;
    }
    if (option == _correctAnswer && !_isCorrect) {
      return Colors.green.shade100;
    }
    return Colors.white;
  }

  Color _getOptionBorderColor(int option) {
    if (!_showFeedback) return AppColors.mathColor;
    if (option == _selectedAnswer) {
      return _isCorrect ? Colors.green : Colors.red;
    }
    if (option == _correctAnswer && !_isCorrect) {
      return Colors.green;
    }
    return AppColors.mathColor.withValues(alpha: 0.3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCharacter(),
                          _buildProblem(),
                          _buildOptions(),
                          if (_showFeedback) _buildFeedback(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    '¿Salir del juego?',
                    style: GoogleFonts.fredoka(fontWeight: FontWeight.w600),
                  ),
                  content: Text(
                    'Perderás tu progreso actual',
                    style: GoogleFonts.fredoka(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancelar', style: GoogleFonts.fredoka()),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.pop();
                      },
                      child: Text('Salir', style: GoogleFonts.fredoka()),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _timeRemaining <= 10 ? Colors.red : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.timer,
                  size: 20,
                  color: _timeRemaining <= 10 ? Colors.white : const Color(0xFF1a1a2e),
                ),
                const SizedBox(width: 6),
                Text(
                  '${_timeRemaining}s',
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _timeRemaining <= 10 ? Colors.white : const Color(0xFF1a1a2e),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          if (_consecutiveCorrect > 1)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department, size: 20, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    '${_consecutiveCorrect}x',
                    style: GoogleFonts.fredoka(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, size: 20, color: Colors.amber),
                const SizedBox(width: 6),
                Text(
                  '$_currentScore',
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1a1a2e),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacter() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: _showFeedback && _isCorrect ? 1 : 0),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: 1 + (value * 0.2),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a2e).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.rocket_launch,
              size: 60,
              color: Color(0xFF1a1a2e),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProblem() {
    return Column(
      children: [
        Text(
          '¿Cuántos hay en total?',
          style: GoogleFonts.fredoka(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$_num1 grupos × $_num2',
          style: GoogleFonts.fredoka(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 20),

        // Mostrar grupos en filas
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: List.generate(_num1, (groupIndex) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1a1a2e).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF1a1a2e).withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: List.generate(_num2, (itemIndex) {
                  return Text(
                    _currentEmoji,
                    style: const TextStyle(fontSize: 24),
                  );
                }),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildOptions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _options.map((option) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Material(
              color: _getOptionColor(option),
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: _showFeedback ? null : () => _checkAnswer(option),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _getOptionBorderColor(option),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '$option',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.fredoka(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1a1a2e),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeedback() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isCorrect ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isCorrect ? Colors.green : Colors.red,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isCorrect ? Icons.check_circle : Icons.cancel,
                  color: _isCorrect ? Colors.green : Colors.red,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    _isCorrect
                        ? '¡Excelente! +${15 + (_timeRemaining / 10).floor() * 3 + ((_consecutiveCorrect > 1) ? (_consecutiveCorrect - 1) * 7 : 0)} puntos'
                        : '¡Ops! Era $_correctAnswer (-7 puntos)',
                    style: GoogleFonts.fredoka(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _isCorrect ? Colors.green.shade900 : Colors.red.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
