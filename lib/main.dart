/// Punto de entrada principal de la aplicación
///
/// Este archivo inicializa todos los servicios necesarios:
/// - Firebase (Authentication, Firestore, Storage)
/// - Hive (almacenamiento local)
/// - Dependency Injection
/// - BLoC Observers para debugging
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'app/config/avatar_catalog.dart';
import 'data/datasources/remote/firebase_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/game_repository.dart';
import 'data/repositories/progress_repository.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await FirebaseService.initialize();

  // Inicializar Hive para almacenamiento local
  await Hive.initFlutter();

  // Cargar catálogo dinámico de avatares
  await AvatarCatalog.initialize();

  runApp(const MyApp());
}

/// Widget raíz de la aplicación
/// Configura los repositorios y BLoCs principales
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => GameRepository()),
        RepositoryProvider(create: (_) => ProgressRepository()),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: context.read<AuthRepository>(),
        )..add(AuthCheckRequested()),
        child: const VideoJuegoEducativoApp(),
      ),
    );
  }
}
