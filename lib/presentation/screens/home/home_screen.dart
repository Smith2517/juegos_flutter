library;

/// Pantalla principal con las 4 categorías de juegos en una sola fila
///
/// Muestra: Puntuación total, Ranking, y 4 categorías horizontales
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../app/theme/colors.dart';
import '../../../domain/services/avatar_service.dart';
import '../../widgets/avatar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Si no está autenticado, redirigir a login
        if (state is! AuthAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/login');
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = state.user;

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4A90E2),
                  Color(0xFF50E3C2),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header con nombre
                  _buildHeader(context, user.displayName, user.avatarId),

                  // Contenido principal
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Puntuación y Ranking
                            _buildScoreAndRanking(context),

                            const SizedBox(height: 32),

                            // Título
                            Text(
                              '¿Qué quieres aprender hoy?',
                              style: GoogleFonts.fredoka(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Categorías en fila horizontal
                            _buildCategoriesRow(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, String userName, String avatarId) {
    final user = FirebaseAuth.instance.currentUser;
    final avatarService = AvatarService();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Avatar + Saludo (clickeable para ir al perfil)
          Expanded(
            child: GestureDetector(
              onTap: () => context.push('/profile'),
              child: Row(
                children: [
                  // Avatar con StreamBuilder
                  if (user != null)
                    StreamBuilder(
                      stream: avatarService.avatarStream(user.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return SimpleAvatarWidget(
                            avatar: snapshot.data!,
                            size: 60,
                          );
                        }
                        // Placeholder mientras carga
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 32,
                            color: AppColors.primary,
                          ),
                        );
                      },
                    )
                  else
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 32,
                        color: AppColors.primary,
                      ),
                    ),
                  const SizedBox(width: 16),

                  // Saludo
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Hola, $userName!',
                          style: GoogleFonts.fredoka(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Listo para aprender',
                          style: GoogleFonts.fredoka(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Botón de tienda
          IconButton(
            icon: const Icon(Icons.shopping_bag, color: Colors.white),
            iconSize: 28,
            onPressed: () => context.push('/shop'),
          ),

          // Botón de logout
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            iconSize: 28,
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScoreAndRanking(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        int totalScore = 0;
        int gamesPlayed = 0;

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          totalScore = (data['totalScore'] ?? 0) as int;
          gamesPlayed = (data['gamesPlayed'] ?? 0) as int;
        }

        return Row(
          children: [
            // Tarjeta de puntuación
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA726), Color(0xFFFF9800)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 32),
                        const SizedBox(width: 8),
                        Text(
                          'Mis Puntos',
                          style: GoogleFonts.fredoka(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$totalScore',
                      style: GoogleFonts.fredoka(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$gamesPlayed juegos jugados',
                      style: GoogleFonts.fredoka(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Botón de ranking
            GestureDetector(
              onTap: () => context.push('/ranking'),
              child: Container(
                width: 140,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF2196F3)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      color: Colors.amber,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Ver\nRanking',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fredoka(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoriesRow(BuildContext context) {
    final categories = [
      {
        'id': 'math',
        'title': 'Matemáticas',
        'description': 'Números y operaciones divertidas',
        'icon': Icons.calculate,
        'gradient': [const Color(0xFF5C6AC4), const Color(0xFF4A5AB7)],
      },
      {
        'id': 'language',
        'title': 'Lenguaje',
        'description': 'Letras, palabras y lectura',
        'icon': Icons.abc,
        'gradient': [const Color(0xFFE74C3C), const Color(0xFFC0392B)],
      },
      {
        'id': 'science',
        'title': 'Ciencias',
        'description': 'Descubre el mundo',
        'icon': Icons.science,
        'gradient': [const Color(0xFF27AE60), const Color(0xFF229954)],
      },
      {
        'id': 'creativity',
        'title': 'Creatividad',
        'description': 'Arte, música y más',
        'icon': Icons.palette,
        'gradient': [const Color(0xFFF39C12), const Color(0xFFE67E22)],
      },
    ];

    return Row(
      children: categories.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < categories.length - 1 ? 16 : 0),
            child: _buildCategoryCard(
              context,
              id: category['id'] as String,
              title: category['title'] as String,
              description: category['description'] as String,
              icon: category['icon'] as IconData,
              gradient: category['gradient'] as List<Color>,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String id,
    required String title,
    required String description,
    required IconData icon,
    required List<Color> gradient,
  }) {
    return GestureDetector(
      onTap: () {
        context.push('/games/$id');
      },
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icono grande
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 56,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Título grande
              Text(
                title,
                style: GoogleFonts.fredoka(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Descripción
              Text(
                description,
                style: GoogleFonts.fredoka(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.95),
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          '¿Salir?',
          style: GoogleFonts.fredoka(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          '¿Estás seguro que quieres salir?',
          style: GoogleFonts.fredoka(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancelar',
              style: GoogleFonts.fredoka(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthBloc>().add(AuthLogoutRequested());
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Salir',
              style: GoogleFonts.fredoka(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
