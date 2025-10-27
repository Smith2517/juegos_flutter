/// Repositorio de progreso
///
/// Maneja el progreso y estadísticas del usuario
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressRepository {
  final FirebaseFirestore _firestore;

  ProgressRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // TODO: Implementar métodos cuando se creen los modelos

  /// Guardar progreso del usuario en un juego
  Future<void> saveProgress(Map<String, dynamic> progress) async {
    try {
      final userId = progress['userId'] as String;
      final gameId = progress['gameId'] as String;
      final docId = '${userId}_$gameId';

      await _firestore
          .collection('progress')
          .doc(docId)
          .set(progress, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error al guardar progreso: $e');
    }
  }

  /// Obtener todo el progreso de un usuario
  Stream<List<Map<String, dynamic>>> getUserProgress(String userId) {
    return _firestore
        .collection('progress')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Obtener progreso específico de un juego
  Future<Map<String, dynamic>?> getGameProgress(String userId, String gameId) async {
    try {
      final docId = '${userId}_$gameId';
      final doc = await _firestore.collection('progress').doc(docId).get();

      if (doc.exists && doc.data() != null) {
        return doc.data();
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener progreso: $e');
    }
  }
}
