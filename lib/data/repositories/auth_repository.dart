/// Repositorio de autenticación
///
/// Maneja todas las operaciones de autenticación con Firebase
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../../domain/services/avatar_service.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final AvatarService _avatarService;

  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    AvatarService? avatarService,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _avatarService = avatarService ?? AvatarService();

  /// Stream de cambios de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Usuario actual de Firebase
  User? get currentUser => _auth.currentUser;

  /// Verificar si el nombre de usuario ya existe
  Future<bool> usernameExists(String username) async {
    try {
      final query = await _firestore
          .collection('users')
          .where('username', isEqualTo: username.toLowerCase())
          .limit(1)
          .get();

      return query.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error al verificar usuario: $e');
    }
  }

  /// Registrar nuevo usuario con credenciales
  Future<UserModel> register({
    required String username,
    required String password,
    required String displayName,
    required String avatarId,
    required int age,
    String gender = 'male', // 'male' o 'female'
  }) async {
    try {
      // Verificar que el username no exista
      final exists = await usernameExists(username);
      if (exists) {
        throw Exception('El nombre de usuario ya existe');
      }

      // Crear email temporal para Firebase Auth (username@eduapp.local)
      final email = '${username.toLowerCase()}@eduapp.local';

      // Crear usuario con Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // Crear modelo de usuario
      final userModel = UserModel(
        userId: uid,
        username: username.toLowerCase(),
        displayName: displayName,
        avatarId: avatarId,
        age: age,
        dateCreated: DateTime.now(),
        settings: const UserSettings(),
      );

      // Guardar en Firestore
      await _firestore.collection('users').doc(uid).set(userModel.toJson());

      // Crear avatar inicial según el género
      await _avatarService.createDefaultAvatar(uid, gender);

      return userModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('El nombre de usuario ya existe');
      } else if (e.code == 'weak-password') {
        throw Exception('La contraseña es muy débil (mínimo 6 caracteres)');
      }
      throw Exception('Error al registrar: ${e.message}');
    } catch (e) {
      throw Exception('Error al registrar usuario: $e');
    }
  }

  /// Iniciar sesión con credenciales
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      // Convertir username a email
      final email = '${username.toLowerCase()}@eduapp.local';

      // Autenticar con Firebase
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // Obtener datos del usuario desde Firestore
      final userData = await getUserData(uid);

      if (userData == null) {
        throw Exception('Usuario no encontrado');
      }

      // Verificar y crear avatar si no existe (para usuarios antiguos)
      await _avatarService.ensureAvatarExists(uid);

      return userData;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Usuario no encontrado');
      } else if (e.code == 'wrong-password') {
        throw Exception('Contraseña incorrecta');
      }
      throw Exception('Error al iniciar sesión: ${e.message}');
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  /// Vincular email parental a cuenta anónima
  Future<void> linkParentalEmail(String email, String password) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await currentUser?.linkWithCredential(credential);

      // Actualizar email parental en Firestore
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'parentEmail': email,
        });
      }
    } catch (e) {
      throw Exception('Error al vincular email: $e');
    }
  }

  /// Obtener datos de usuario desde Firestore
  Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener usuario: $e');
    }
  }

  /// Actualizar datos de usuario
  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.userId)
          .update(user.toJson());
    } catch (e) {
      throw Exception('Error al actualizar usuario: $e');
    }
  }

  /// Cerrar sesión
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  /// Verificar si el usuario está autenticado
  bool get isAuthenticated => currentUser != null;
}
