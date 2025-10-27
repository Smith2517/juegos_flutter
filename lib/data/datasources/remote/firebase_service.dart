/// Servicio base de Firebase
///
/// Inicializa y proporciona acceso a los servicios de Firebase
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  // Prevenir instanciación
  FirebaseService._();

  /// Instancia de Firestore
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  /// Instancia de Auth
  static FirebaseAuth get auth => FirebaseAuth.instance;

  /// Instancia de Storage
  static FirebaseStorage get storage => FirebaseStorage.instance;

  /// Inicializar Firebase
  ///
  /// Debe ser llamado en main() antes de runApp()
  static Future<void> initialize() async {
    // Verificar si Firebase ya está inicializado
    if (isInitialized) {
      print('⚠️ Firebase ya está inicializado - omitiendo inicialización');
      return;
    }

    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyCe-nrJOEP3txjC_O0gNnPBB7gaQWrddU8',
          authDomain: 'plataforma-web--ni.firebaseapp.com',
          projectId: 'plataforma-web--ni',
          storageBucket: 'plataforma-web--ni.firebasestorage.app',
          messagingSenderId: '111380918033',
          appId: '1:111380918033:web:f1fe73fe640c80ce57a6b0',
          measurementId: 'G-Y6GV0RS23K',
        ),
      );

      // Configurar Firestore para persistencia offline
      firestore.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );

      print('✅ Firebase inicializado correctamente');
    } catch (e) {
      print('❌ Error al inicializar Firebase: $e');
      print('⚠️ La app continuará en modo DEMO sin Firebase');
      // No lanzar error para que la app pueda continuar
    }
  }

  /// Verificar si Firebase está inicializado
  static bool get isInitialized {
    try {
      Firebase.app();
      return true;
    } catch (e) {
      return false;
    }
  }
}
