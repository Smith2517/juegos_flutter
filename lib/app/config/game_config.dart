library;

/// Configuración de Juegos
///
/// Define las dificultades, puntos y recompensas de monedas para cada juego.
///
/// Autor: Sistema Educativo
/// Fecha: 2025

class GameConfig {
  // Mapa de gameId a configuración de dificultad
  static const Map<String, GameDifficulty> gameDifficulties = {
    // MATEMÁTICAS
    'suma_aventurera': GameDifficulty(level: 1, pointsPerCorrect: 10, penalty: 5, coinsReward: 10),
    'resta_magica': GameDifficulty(level: 1, pointsPerCorrect: 10, penalty: 5, coinsReward: 10),
    'multiplicacion_espacial': GameDifficulty(level: 2, pointsPerCorrect: 12, penalty: 6, coinsReward: 15),
    'division_detective': GameDifficulty(level: 3, pointsPerCorrect: 15, penalty: 7, coinsReward: 20),
    'geometria_constructora': GameDifficulty(level: 4, pointsPerCorrect: 18, penalty: 8, coinsReward: 25),
    'numeros_perdidos': GameDifficulty(level: 5, pointsPerCorrect: 20, penalty: 10, coinsReward: 30),

    // LENGUAJE
    'cazador_vocales': GameDifficulty(level: 1, pointsPerCorrect: 10, penalty: 5, coinsReward: 10),
    'constructor_palabras': GameDifficulty(level: 1, pointsPerCorrect: 10, penalty: 5, coinsReward: 10),
    'rima_magica': GameDifficulty(level: 3, pointsPerCorrect: 15, penalty: 7, coinsReward: 20),
    'detectives_ortografia': GameDifficulty(level: 3, pointsPerCorrect: 15, penalty: 7, coinsReward: 20),
    'sinonimos_antonimos': GameDifficulty(level: 4, pointsPerCorrect: 18, penalty: 8, coinsReward: 25),
    'aventura_comprension': GameDifficulty(level: 5, pointsPerCorrect: 20, penalty: 10, coinsReward: 30),

    // CIENCIAS
    'exploradores_cuerpo': GameDifficulty(level: 1, pointsPerCorrect: 10, penalty: 5, coinsReward: 10),
    'cadena_alimenticia': GameDifficulty(level: 2, pointsPerCorrect: 12, penalty: 6, coinsReward: 15),
    'estados_materia': GameDifficulty(level: 2, pointsPerCorrect: 12, penalty: 6, coinsReward: 15),
    'ecosistemas_mundo': GameDifficulty(level: 3, pointsPerCorrect: 15, penalty: 7, coinsReward: 20),
    'planeta_tierra': GameDifficulty(level: 4, pointsPerCorrect: 18, penalty: 8, coinsReward: 25),
    'sistema_solar': GameDifficulty(level: 5, pointsPerCorrect: 20, penalty: 10, coinsReward: 30),

    // CREATIVIDAD
    'mezcla_colores': GameDifficulty(level: 1, pointsPerCorrect: 10, penalty: 5, coinsReward: 10),
    'completa_patron': GameDifficulty(level: 2, pointsPerCorrect: 12, penalty: 6, coinsReward: 15),
    'historias_locas': GameDifficulty(level: 2, pointsPerCorrect: 12, penalty: 6, coinsReward: 15),
    'asociacion_creativa': GameDifficulty(level: 3, pointsPerCorrect: 15, penalty: 7, coinsReward: 20),
    'artista_emojis': GameDifficulty(level: 4, pointsPerCorrect: 18, penalty: 8, coinsReward: 25),
    'inventor_palabras': GameDifficulty(level: 5, pointsPerCorrect: 20, penalty: 10, coinsReward: 30),
  };

  /// Obtiene la configuración de dificultad de un juego
  static GameDifficulty getDifficulty(String gameId) {
    return gameDifficulties[gameId] ?? const GameDifficulty(
      level: 1,
      pointsPerCorrect: 10,
      penalty: 5,
      coinsReward: 10,
    );
  }

  /// Obtiene las monedas de recompensa para un juego
  static int getCoinsReward(String gameId) {
    return getDifficulty(gameId).coinsReward;
  }

  /// Obtiene los puntos por respuesta correcta para un juego
  static int getPointsPerCorrect(String gameId) {
    return getDifficulty(gameId).pointsPerCorrect;
  }

  /// Obtiene la penalización por respuesta incorrecta para un juego
  static int getPenalty(String gameId) {
    return getDifficulty(gameId).penalty;
  }

  /// Obtiene el nivel de dificultad de un juego
  static int getDifficultyLevel(String gameId) {
    return getDifficulty(gameId).level;
  }

  /// Obtiene el emoji de dificultad
  static String getDifficultyEmoji(int level) {
    switch (level) {
      case 1:
        return '⭐';
      case 2:
        return '⭐⭐';
      case 3:
        return '⭐⭐⭐';
      case 4:
        return '⭐⭐⭐⭐';
      case 5:
        return '⭐⭐⭐⭐⭐';
      default:
        return '⭐';
    }
  }

  /// Obtiene el texto de dificultad
  static String getDifficultyText(int level) {
    switch (level) {
      case 1:
        return 'Fácil';
      case 2:
        return 'Medio-Fácil';
      case 3:
        return 'Medio';
      case 4:
        return 'Medio-Difícil';
      case 5:
        return 'Difícil';
      default:
        return 'Fácil';
    }
  }
}

/// Clase que representa la dificultad de un juego
class GameDifficulty {
  final int level; // 1-5 (Fácil a Difícil)
  final int pointsPerCorrect; // Puntos por respuesta correcta
  final int penalty; // Puntos a restar por respuesta incorrecta
  final int coinsReward; // Monedas al completar el juego

  const GameDifficulty({
    required this.level,
    required this.pointsPerCorrect,
    required this.penalty,
    required this.coinsReward,
  });
}
