library;

/// Juego: Constructor de Palabras
///
/// Los niños deben formar palabras correctas seleccionando sílabas en el orden correcto.
/// Sistema de puntuación con penalizaciones por errores.
///
/// Autor: Sistema Educativo
/// Fecha: 2025

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstructorPalabrasGame extends StatefulWidget {
  const ConstructorPalabrasGame({super.key});

  @override
  State<ConstructorPalabrasGame> createState() => _ConstructorPalabrasGameState();
}

class _ConstructorPalabrasGameState extends State<ConstructorPalabrasGame> {
  final Random _random = Random();

  // Palabras divididas en sílabas
  final List<Map<String, dynamic>> _words = [
    {'syllables': ['PE', 'LO', 'TA'], 'emoji': '⚽', 'correct': 'PELOTA'},
    {'syllables': ['GA', 'TO'], 'emoji': '🐱', 'correct': 'GATO'},
    {'syllables': ['CA', 'SA'], 'emoji': '🏠', 'correct': 'CASA'},
    {'syllables': ['MA', 'RI', 'PO', 'SA'], 'emoji': '🦋', 'correct': 'MARIPOSA'},
    {'syllables': ['CO', 'NE', 'JO'], 'emoji': '🐰', 'correct': 'CONEJO'},
    {'syllables': ['ES', 'TRE', 'LLA'], 'emoji': '⭐', 'correct': 'ESTRELLA'},
    {'syllables': ['TOR', 'TU', 'GA'], 'emoji': '🐢', 'correct': 'TORTUGA'},
    {'syllables': ['PLA', 'TA', 'NO'], 'emoji': '🍌', 'correct': 'PLATANO'},
    {'syllables': ['VEN', 'TA', 'NA'], 'emoji': '🪟', 'correct': 'VENTANA'},
    {'syllables': ['E', 'LE', 'FAN', 'TE'], 'emoji': '🐘', 'correct': 'ELEFANTE'},
    {'syllables': ['CA', 'MI', 'SE', 'TA'], 'emoji': '👕', 'correct': 'CAMISETA'},
    {'syllables': ['ZA', 'PA', 'TO'], 'emoji': '👞', 'correct': 'ZAPATO'},
    {'syllables': ['CHO', 'CO', 'LA', 'TE'], 'emoji': '🍫', 'correct': 'CHOCOLATE'},
    {'syllables': ['BI', 'CI', 'CLE', 'TA'], 'emoji': '🚲', 'correct': 'BICICLETA'},
    {'syllables': ['PAN', 'TA', 'LON'], 'emoji': '👖', 'correct': 'PANTALON'},
  ];

  List<String> _availableSyllables = [];
  List<String> _selectedSyllables = [];
  String _correctWord = '';
  String _emoji = '';

  int _currentScore = 0;
  int _questionsAnswered = 0;
  int _correctAnswers = 0;
  int _consecutiveCorrect = 0;

  bool _showFeedback = false;
  bool _isCorrect = false;
  String _feedbackMessage = '';

  Timer? _gameTimer;
  int _timeRemaining = 60;

  final int _totalQuestions = 10;

  @override
  void initState() {
    super.initState();
    _generateProblem();
    _startTimer();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timeRemaining > 0) {
            _timeRemaining--;
          } else {
            _endGame();
          }
        });
      }
    });
  }

  void _generateProblem() {
    final wordData = _words[_random.nextInt(_words.length)];
    final syllables = List<String>.from(wordData['syllables'] as List);
    syllables.shuffle(_random);

    setState(() {
      _availableSyllables = syllables;
      _selectedSyllables = [];
      _correctWord = wordData['correct'] as String;
      _emoji = wordData['emoji'] as String;
      _showFeedback = false;
    });
  }

  void _selectSyllable(String syllable) {
    if (_showFeedback) return;

    setState(() {
      _selectedSyllables.add(syllable);
      _availableSyllables.remove(syllable);
    });
  }

  void _removeSyllable(int index) {
    if (_showFeedback) return;

    setState(() {
      final syllable = _selectedSyllables.removeAt(index);
      _availableSyllables.add(syllable);
    });
  }

  void _checkAnswer() {
    if (_showFeedback || _selectedSyllables.isEmpty) return;

    final formedWord = _selectedSyllables.join('');
    final isCorrect = formedWord == _correctWord;

    setState(() {
      _showFeedback = true;
      _isCorrect = isCorrect;
      _questionsAnswered++;

      if (isCorrect) {
        _correctAnswers++;
        _consecutiveCorrect++;
        final bonusMultiplier = (_consecutiveCorrect / 3).floor() + 1;
        _currentScore += 10 * bonusMultiplier;
        _feedbackMessage = _consecutiveCorrect >= 3
            ? '¡Increíble! Racha de $_consecutiveCorrect 🔥'
            : '¡Excelente! +${10 * bonusMultiplier} puntos';
      } else {
        _consecutiveCorrect = 0;
        _currentScore = max(0, _currentScore - 5);
        _feedbackMessage = 'Intenta de nuevo. -5 puntos';
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        if (_questionsAnswered >= _totalQuestions) {
          _endGame();
        } else {
          _generateProblem();
        }
      }
    });
  }

  void _endGame() {
    _gameTimer?.cancel();

    final accuracy = _questionsAnswered > 0
        ? ((_correctAnswers / _questionsAnswered) * 100).round()
        : 0;

    context.push('/game-results', extra: {
      'gameId': 'constructor_palabras',
      'gameName': 'Constructor de Palabras',
      'score': _currentScore,
      'questionsAnswered': _questionsAnswered,
      'correctAnswers': _correctAnswers,
      'accuracy': accuracy,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red.shade400,
              Colors.red.shade600,
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
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 16),
                            _buildCharacter(),
                            const SizedBox(height: 20),
                            _buildProblem(),
                            const SizedBox(height: 20),
                            _buildSelectedArea(),
                            const SizedBox(height: 20),
                            _buildAvailableSyllables(),
                            const SizedBox(height: 20),
                            _buildCheckButton(),
                            const SizedBox(height: 16),
                            if (_showFeedback) _buildFeedback(),
                            const SizedBox(height: 16),
                          ],
                        ),
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
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Salir del juego', style: GoogleFonts.fredoka()),
                  content: Text(
                    '¿Estás seguro de que quieres salir? Perderás tu progreso.',
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
                  color: _timeRemaining <= 10 ? Colors.white : Colors.red.shade700,
                ),
                const SizedBox(width: 6),
                Text(
                  '${_timeRemaining}s',
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _timeRemaining <= 10 ? Colors.white : Colors.red.shade700,
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
                    color: Colors.red.shade700,
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
              color: Colors.red.shade100,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '🔨',
                style: TextStyle(fontSize: 60),
              ),
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
          'Forma la palabra correcta',
          style: GoogleFonts.fredoka(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _emoji,
          style: const TextStyle(fontSize: 60),
        ),
      ],
    );
  }

  Widget _buildSelectedArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _showFeedback
            ? (_isCorrect ? Colors.green.shade50 : Colors.red.shade50)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _showFeedback
              ? (_isCorrect ? Colors.green : Colors.red)
              : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Tu palabra:',
            style: GoogleFonts.fredoka(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 12),
          _selectedSyllables.isEmpty
              ? Text(
                  'Selecciona las sílabas...',
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    color: Colors.grey.shade400,
                    fontStyle: FontStyle.italic,
                  ),
                )
              : Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    _selectedSyllables.length,
                    (index) => GestureDetector(
                      onTap: () => _removeSyllable(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.red.shade400,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          _selectedSyllables[index],
                          style: GoogleFonts.fredoka(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildAvailableSyllables() {
    if (_availableSyllables.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Text(
          'Sílabas disponibles:',
          style: GoogleFonts.fredoka(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: _availableSyllables.map((syllable) {
            return GestureDetector(
              onTap: () => _selectSyllable(syllable),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.red.shade300,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.shade100,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  syllable,
                  style: GoogleFonts.fredoka(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCheckButton() {
    if (_showFeedback) return const SizedBox.shrink();

    return ElevatedButton(
      onPressed: _selectedSyllables.isNotEmpty ? _checkAnswer : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        disabledBackgroundColor: Colors.grey.shade300,
      ),
      child: Text(
        'Verificar',
        style: GoogleFonts.fredoka(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFeedback() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isCorrect ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isCorrect ? Colors.green : Colors.red,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isCorrect ? Icons.check_circle : Icons.cancel,
                color: _isCorrect ? Colors.green : Colors.red,
                size: 32,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  _feedbackMessage,
                  style: GoogleFonts.fredoka(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: _isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          if (!_isCorrect) ...[
            const SizedBox(height: 8),
            Text(
              'Palabra correcta: $_correctWord',
              style: GoogleFonts.fredoka(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
