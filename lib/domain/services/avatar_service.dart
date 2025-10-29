library;

/// Servicio de Gestión de Avatares
///
/// Maneja todas las operaciones de avatares con Firebase:
/// - Crear avatar inicial
/// - Actualizar partes del avatar
/// - Comprar nuevas partes
/// - Obtener avatar del usuario
///
/// Autor: Sistema Educativo
/// Fecha: 2025

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/avatar_model.dart';
import '../models/avatar_part_item.dart';
import '../../app/config/avatar_catalog.dart';

class AvatarService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Crea un avatar inicial para un nuevo usuario
  Future<void> createDefaultAvatar(String userId, String gender) async {
    try {
      print('🎨 Creando avatar para userId: $userId, gender: $gender');

      final avatar = gender == 'female'
          ? AvatarModel.defaultFemale(userId)
          : AvatarModel.defaultMale(userId);

      print('🎨 Avatar creado: ${avatar.toMap()}');

      await _firestore.collection('avatars').doc(userId).set(avatar.toMap());

      print('✅ Avatar guardado exitosamente en Firebase');
    } catch (e) {
      print('❌ Error al crear avatar: $e');
      throw Exception('Error al crear avatar: $e');
    }
  }

  /// Obtiene el avatar de un usuario
  Future<AvatarModel?> getAvatar(String userId) async {
    try {
      final doc = await _firestore.collection('avatars').doc(userId).get();

      if (!doc.exists) {
        return null;
      }

      return AvatarModel.fromMap(doc.data()!);
    } catch (e) {
      throw Exception('Error al obtener avatar: $e');
    }
  }

  /// Stream del avatar del usuario (para actualizaciones en tiempo real)
  Stream<AvatarModel?> avatarStream(String userId) {
    print('📡 Iniciando stream para userId: $userId');
    return _firestore
        .collection('avatars')
        .doc(userId)
        .snapshots()
        .map((doc) {
      print('📡 Snapshot recibido - exists: ${doc.exists}');
      if (!doc.exists) {
        print('⚠️ Avatar no existe para userId: $userId');
        return null;
      }
      final data = doc.data();
      print('📦 Data recibida: $data');
      return AvatarModel.fromMap(data!);
    });
  }

  /// Actualiza una parte específica del avatar
  Future<void> updateAvatarPart({
    required String userId,
    required String category,
    required String partId,
  }) async {
    try {
      final updateData = <String, dynamic>{};

      switch (category) {
        case 'face':
          updateData['face'] = partId;
          break;
        case 'body':
          updateData['body'] = partId;
          break;
        case 'eyes':
          updateData['eyes'] = partId;
          break;
        case 'mouth':
          updateData['mouth'] = partId;
          break;
        case 'hair':
          updateData['hair'] = partId;
          break;
        case 'top':
          updateData['top'] = partId;
          break;
        case 'bottom':
          updateData['bottom'] = partId;
          break;
        case 'shoes':
          updateData['shoes'] = partId;
          break;
        case 'hands':
          updateData['hands'] = partId;
          break;
        case 'accessory':
          updateData['accessory'] = partId;
          break;
        case 'background':
          updateData['background'] = partId;
          break;
      }

      await _firestore.collection('avatars').doc(userId).update(updateData);
    } catch (e) {
      throw Exception('Error al actualizar parte del avatar: $e');
    }
  }

  /// Compra una parte del avatar con monedas
  Future<bool> purchaseAvatarPart({
    required String userId,
    required String partId,
  }) async {
    try {
      final part = AvatarCatalog.getPartById(partId);
      if (part == null) {
        throw Exception('Parte no encontrada');
      }

      // Verificar si el usuario tiene suficientes monedas
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final userData = userDoc.data();
      if (userData == null) {
        throw Exception('Usuario no encontrado');
      }

      final currentCoins = userData['coins'] as int? ?? 0;
      if (currentCoins < part.price) {
        return false; // No tiene suficientes monedas
      }

      // Verificar si ya tiene la parte desbloqueada
      final avatarDoc = await _firestore.collection('avatars').doc(userId).get();
      final avatar = AvatarModel.fromMap(avatarDoc.data()!);

      final unlockedList = _getUnlockedList(avatar, part.category);
      if (unlockedList.contains(part.id)) {
        throw Exception('Ya tienes esta parte desbloqueada');
      }

      // Realizar la transacción
      await _firestore.runTransaction((transaction) async {
        // Restar monedas
        transaction.update(
          _firestore.collection('users').doc(userId),
          {'coins': FieldValue.increment(-part.price)},
        );

        // Agregar parte a la lista de desbloqueados
        final fieldName = _unlockedFieldName(part.category);
        transaction.update(
          _firestore.collection('avatars').doc(userId),
          {
            fieldName: FieldValue.arrayUnion([part.id]),
          },
        );

        // Si es la primera compra de esta categoría, equiparla automáticamente
        if (unlockedList.length == 1) {
          transaction.update(
            _firestore.collection('avatars').doc(userId),
            {part.category: part.id},
          );
        }
      });

      return true; // Compra exitosa
    } catch (e) {
      throw Exception('Error al comprar parte del avatar: $e');
    }
  }

  /// Obtiene la lista de partes desbloqueadas según la categoría
  List<String> _getUnlockedList(AvatarModel avatar, String category) {
    switch (category) {
      case 'face':
        return avatar.unlockedFaces;
      case 'body':
        return avatar.unlockedBodies;
      case 'eyes':
        return avatar.unlockedEyes;
      case 'mouth':
        return avatar.unlockedMouths;
      case 'hair':
        return avatar.unlockedHairs;
      case 'top':
        return avatar.unlockedTops;
      case 'bottom':
        return avatar.unlockedBottoms;
      case 'shoes':
        return avatar.unlockedShoes;
      case 'hands':
        return avatar.unlockedHands;
      case 'accessory':
        return avatar.unlockedAccessories;
      case 'background':
        return avatar.unlockedBackgrounds;
      default:
        return [];
    }
  }

  String _unlockedFieldName(String category) {
    switch (category) {
      case 'face':
        return 'unlockedFaces';
      case 'body':
        return 'unlockedBodies';
      case 'eyes':
        return 'unlockedEyes';
      case 'mouth':
        return 'unlockedMouths';
      case 'hair':
        return 'unlockedHairs';
      case 'top':
        return 'unlockedTops';
      case 'bottom':
        return 'unlockedBottoms';
      case 'shoes':
        return 'unlockedShoes';
      case 'hands':
        return 'unlockedHands';
      case 'accessory':
        return 'unlockedAccessories';
      case 'background':
        return 'unlockedBackgrounds';
      default:
        return 'unlocked${_capitalize(category)}s';
    }
  }

  /// Capitaliza la primera letra de una cadena
  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Actualiza la expresión actual del avatar
  Future<void> updateExpression(String userId, String expression) async {
    try {
      await _firestore.collection('avatars').doc(userId).update({
        'currentExpression': expression,
      });
    } catch (e) {
      throw Exception('Error al actualizar expresión: $e');
    }
  }

  /// Verifica si una parte está desbloqueada
  Future<bool> isPartUnlocked({
    required String userId,
    required String partId,
    required String category,
  }) async {
    try {
      final avatar = await getAvatar(userId);
      if (avatar == null) return false;

      final unlockedList = _getUnlockedList(avatar, category);
      return unlockedList.contains(partId);
    } catch (e) {
      return false;
    }
  }

  /// Verifica si el usuario tiene un avatar, si no lo tiene lo crea con un género por defecto
  Future<void> ensureAvatarExists(String userId, {String gender = 'male'}) async {
    try {
      print('🔍 Verificando si existe avatar para userId: $userId');
      final avatar = await getAvatar(userId);

      if (avatar == null) {
        print('⚠️ Avatar no existe, creando uno nuevo con gender: $gender');
        await createDefaultAvatar(userId, gender);
      } else {
        print('✅ Avatar ya existe para userId: $userId');
      }
    } catch (e) {
      print('❌ Error al verificar/crear avatar: $e');
    }
  }

  /// Obtiene todas las partes desbloqueadas de una categoría
  Future<List<AvatarPartItem>> getUnlockedParts({
    required String userId,
    required String category,
  }) async {
    try {
      final avatar = await getAvatar(userId);
      if (avatar == null) return [];

      final unlockedIds = _getUnlockedList(avatar, category);
      final allParts = AvatarCatalog.getPartsByCategory(category);

      return allParts.where((part) => unlockedIds.contains(part.id)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Obtiene todas las partes disponibles para comprar (no desbloqueadas)
  Future<List<AvatarPartItem>> getAvailablePartsToPurchase({
    required String userId,
    required String category,
  }) async {
    try {
      final avatar = await getAvatar(userId);
      if (avatar == null) return [];

      final unlockedIds = _getUnlockedList(avatar, category);
      final allParts = AvatarCatalog.getPartsByCategory(category);

      return allParts
          .where((part) => !unlockedIds.contains(part.id) && !part.isDefault)
          .toList();
    } catch (e) {
      return [];
    }
  }
}
