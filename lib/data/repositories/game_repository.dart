/// Repositorio de juegos
///
/// Maneja operaciones relacionadas con juegos y preguntas
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:cloud_firestore/cloud_firestore.dart';

class GameRepository {
  final FirebaseFirestore _firestore;

  GameRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // TODO: Implementar métodos cuando se creen los modelos

  /// Obtener juegos por categoría
  Future<List<Map<String, dynamic>>> getGamesByCategory(String categoryId) async {
    try {
      final snapshot = await _firestore
          .collection('games')
          .where('categoryId', isEqualTo: categoryId)
          .where('active', isEqualTo: true)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Error al obtener juegos: $e');
    }
  }

  /// Obtener todos los juegos activos
  Stream<List<Map<String, dynamic>>> getAllGames() {
    return _firestore
        .collection('games')
        .where('active', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Obtener preguntas para un juego específico
  Future<List<Map<String, dynamic>>> getQuestionsForGame({
    required String gameId,
    required String difficulty,
    int limit = 10,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('gameId', isEqualTo: gameId)
          .where('difficulty', isEqualTo: difficulty)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Error al obtener preguntas: $e');
    }
  }
}
