/// Widget principal de la aplicación
///
/// Configura:
/// - Tema de la aplicación
/// - Rutas de navegación
/// - Configuraciones globales
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/bloc/auth/auth_bloc.dart';
import '../presentation/bloc/auth/auth_state.dart';
import 'routes.dart';
import 'theme/app_theme.dart';

class VideoJuegoEducativoApp extends StatelessWidget {
  const VideoJuegoEducativoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return MaterialApp.router(
          title: 'Videojuego Educativo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: AppRoutes.router,
        );
      },
    );
  }
}
