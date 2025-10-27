library;

/// Pantalla de Ranking Global
///
/// Muestra el ranking de todos los usuarios ordenados por puntuación total.
/// Incluye filtros por juego específico y estadísticas del usuario actual.
///
/// Características:
/// - Top 100 jugadores globales
/// - Filtro por juego específico
/// - Posición del usuario actual
/// - Actualización en tiempo real desde Firebase
/// - Búsqueda de usuarios
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../app/theme/colors.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedGameId;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Método para obtener los mejores puntajes de cada usuario para un juego específico
  Future<List<Map<String, dynamic>>> _getBestScoresForGame(
    String gameId,
    List<QueryDocumentSnapshot> userDocs,
  ) async {
    List<Map<String, dynamic>> bestScores = [];

    for (var userDoc in userDocs) {
      final userId = userDoc.id;
      final userData = userDoc.data() as Map<String, dynamic>;
      final username = userData['username'] ?? 'Jugador';

      // Obtener el mejor puntaje del usuario para este juego
      final gameScoreDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('gameScores')
          .doc(gameId)
          .get();

      if (gameScoreDoc.exists) {
        final gameScoreData = gameScoreDoc.data() as Map<String, dynamic>;
        bestScores.add({
          'userId': userId,
          'username': username,
          'score': gameScoreData['bestScore'] ?? 0,
          'accuracy': gameScoreData['bestAccuracy'] ?? 0,
          'stars': gameScoreData['bestStars'] ?? 0,
        });
      }
    }

    // Ordenar por puntaje descendente
    bestScores.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

    // Retornar top 50
    return bestScores.take(50).toList();
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
              AppColors.primary,
              AppColors.primary.withValues(alpha: 0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Pestañas
              _buildTabs(),

              // Contenido
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildGlobalRanking(),
                    _buildGameRanking(),
                  ],
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ranking Global',
                  style: GoogleFonts.fredoka(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Compite con otros jugadores',
                  style: GoogleFonts.fredoka(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.emoji_events, color: Colors.amber, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.white,
            labelStyle: GoogleFonts.fredoka(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: 'Top Global'),
              Tab(text: 'Por Juego'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlobalRanking() {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              // Barra de búsqueda
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              style: GoogleFonts.fredoka(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar usuario...',
                hintStyle: GoogleFonts.fredoka(
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Posición del usuario actual
          if (currentUser != null) _buildCurrentUserPosition(currentUser.uid),

          const SizedBox(height: 16),

          // Lista de ranking
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .orderBy('totalScore', descending: true)
                  .limit(100)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error al cargar ranking',
                      style: GoogleFonts.fredoka(color: Colors.white),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                var users = snapshot.data!.docs;

                // Filtrar por búsqueda
                if (_searchQuery.isNotEmpty) {
                  users = users.where((doc) {
                    final username = (doc.data() as Map<String, dynamic>)['username']
                        ?.toString()
                        .toLowerCase() ??
                        '';
                    return username.contains(_searchQuery);
                  }).toList();
                }

                if (users.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, color: Colors.white, size: 64),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty
                              ? 'No hay jugadores aún'
                              : 'No se encontraron usuarios',
                          style: GoogleFonts.fredoka(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final userData = users[index].data() as Map<String, dynamic>;
                    final isCurrentUser = users[index].id == currentUser?.uid;

                    return _buildRankingCard(
                      position: index + 1,
                      username: (userData['username'] ?? 'Jugador') as String,
                      score: (userData['totalScore'] ?? 0) as int,
                      gamesPlayed: (userData['gamesPlayed'] ?? 0) as int?,
                      isCurrentUser: isCurrentUser,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }

  Widget _buildCurrentUserPosition(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('totalScore', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final users = snapshot.data!.docs;
        final userIndex = users.indexWhere((doc) => doc.id == userId);

        if (userIndex == -1) return const SizedBox.shrink();

        final userData = users[userIndex].data() as Map<String, dynamic>;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amber, width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${userIndex + 1}',
                    style: GoogleFonts.fredoka(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tu Posición',
                      style: GoogleFonts.fredoka(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    Text(
                      (userData['username'] ?? 'Tú') as String,
                      style: GoogleFonts.fredoka(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${userData['totalScore'] ?? 0}',
                    style: GoogleFonts.fredoka(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'puntos',
                    style: GoogleFonts.fredoka(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGameRanking() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              // Selector de juego
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedGameId,
                hint: Text(
                  'Selecciona un juego',
                  style: GoogleFonts.fredoka(color: Colors.white),
                ),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                dropdownColor: AppColors.primary,
                style: GoogleFonts.fredoka(color: Colors.white, fontSize: 16),
                items: [
                  // Juegos de Matemáticas
                  DropdownMenuItem(
                    value: 'suma_aventurera',
                    child: Text('📐 Suma Aventurera', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'resta_magica',
                    child: Text('📐 Resta Mágica', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'multiplicacion_espacial',
                    child: Text('📐 Multiplicación Espacial', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'division_detective',
                    child: Text('📐 División Detective', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'numeros_perdidos',
                    child: Text('📐 Números Perdidos', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'geometria_constructora',
                    child: Text('📐 Geometría Constructora', style: GoogleFonts.fredoka()),
                  ),
                  // Juegos de Lenguaje
                  DropdownMenuItem(
                    value: 'cazador_vocales',
                    child: Text('📚 Cazador de Vocales', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'constructor_palabras',
                    child: Text('📚 Constructor de Palabras', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'rima_magica',
                    child: Text('📚 Rima Mágica', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'detectives_ortografia',
                    child: Text('📚 Detectives de Ortografía', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'sinonimos_antonimos',
                    child: Text('📚 Sinónimos y Antónimos', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'aventura_comprension',
                    child: Text('📚 Aventura de Comprensión', style: GoogleFonts.fredoka()),
                  ),
                  // Juegos de Ciencias
                  DropdownMenuItem(
                    value: 'exploradores_cuerpo',
                    child: Text('🧬 Exploradores del Cuerpo Humano', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'cadena_alimenticia',
                    child: Text('🧬 Cadena Alimenticia', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'estados_materia',
                    child: Text('🧬 Estados de la Materia', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'planeta_tierra',
                    child: Text('🧬 Planeta Tierra', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'ecosistemas_mundo',
                    child: Text('🧬 Ecosistemas del Mundo', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'sistema_solar',
                    child: Text('🧬 Sistema Solar', style: GoogleFonts.fredoka()),
                  ),
                  // Juegos de Creatividad
                  DropdownMenuItem(
                    value: 'mezcla_colores',
                    child: Text('🎨 Mezcla de Colores', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'completa_patron',
                    child: Text('🎨 Completa el Patrón', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'historias_locas',
                    child: Text('🎨 Historias Locas', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'asociacion_creativa',
                    child: Text('🎨 Asociación Creativa', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'artista_emojis',
                    child: Text('🎨 Artista de Emojis', style: GoogleFonts.fredoka()),
                  ),
                  DropdownMenuItem(
                    value: 'inventor_palabras',
                    child: Text('🎨 Inventor de Palabras', style: GoogleFonts.fredoka()),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedGameId = value;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Ranking del juego seleccionado
          if (_selectedGameId != null)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .snapshots(),
                builder: (context, usersSnapshot) {
                  if (usersSnapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error al cargar ranking',
                        style: GoogleFonts.fredoka(color: Colors.white),
                      ),
                    );
                  }

                  if (!usersSnapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  // Obtener todos los usuarios y sus mejores puntajes para este juego
                  return FutureBuilder<List<Map<String, dynamic>>>(
                    future: _getBestScoresForGame(_selectedGameId!, usersSnapshot.data!.docs),
                    builder: (context, scoresSnapshot) {
                      if (!scoresSnapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }

                      final rankedScores = scoresSnapshot.data!;

                      if (rankedScores.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.sports_esports, color: Colors.white, size: 64),
                              const SizedBox(height: 16),
                              Text(
                                'No hay partidas jugadas aún',
                                style: GoogleFonts.fredoka(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '¡Sé el primero en jugar!',
                                style: GoogleFonts.fredoka(
                                  fontSize: 14,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      final currentUser = FirebaseAuth.instance.currentUser;

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: rankedScores.length,
                        itemBuilder: (context, index) {
                          final scoreData = rankedScores[index];
                          final isCurrentUser = scoreData['userId'] == currentUser?.uid;

                          return _buildRankingCard(
                            position: index + 1,
                            username: scoreData['username'] as String,
                            score: scoreData['score'] as int,
                            accuracy: scoreData['accuracy'] as int?,
                            stars: scoreData['stars'] as int?,
                            isCurrentUser: isCurrentUser,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            )
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.videogame_asset, color: Colors.white, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      'Selecciona un juego',
                      style: GoogleFonts.fredoka(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'para ver su ranking',
                      style: GoogleFonts.fredoka(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
        ),
      ),
    );
  }

  Widget _buildRankingCard({
    required int position,
    required String username,
    required int score,
    int? gamesPlayed,
    int? accuracy,
    int? stars,
    required bool isCurrentUser,
  }) {
    Color getPositionColor() {
      if (position == 1) return Colors.amber;
      if (position == 2) return Colors.grey.shade300;
      if (position == 3) return Colors.orange.shade300;
      return Colors.white.withValues(alpha: 0.2);
    }

    IconData getPositionIcon() {
      if (position == 1) return Icons.emoji_events;
      if (position == 2) return Icons.military_tech;
      if (position == 3) return Icons.workspace_premium;
      return Icons.person;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Colors.amber.withValues(alpha: 0.3)
            : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: isCurrentUser
            ? Border.all(color: Colors.amber, width: 2)
            : null,
      ),
      child: Row(
        children: [
          // Posición
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: getPositionColor(),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: position <= 3
                  ? Icon(
                      getPositionIcon(),
                      color: position == 1 ? Colors.white : Colors.grey.shade800,
                      size: 24,
                    )
                  : Text(
                      '$position',
                      style: GoogleFonts.fredoka(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),

          const SizedBox(width: 16),

          // Información del usuario
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        username,
                        style: GoogleFonts.fredoka(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentUser) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Tú',
                          style: GoogleFonts.fredoka(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (gamesPlayed != null) ...[
                      Icon(Icons.gamepad, size: 14, color: Colors.white.withValues(alpha: 0.7)),
                      const SizedBox(width: 4),
                      Text(
                        '$gamesPlayed juegos',
                        style: GoogleFonts.fredoka(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                    if (accuracy != null) ...[
                      const SizedBox(width: 12),
                      Icon(Icons.percent, size: 14, color: Colors.white.withValues(alpha: 0.7)),
                      const SizedBox(width: 4),
                      Text(
                        '$accuracy%',
                        style: GoogleFonts.fredoka(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                    if (stars != null) ...[
                      const SizedBox(width: 12),
                      ...List.generate(
                        stars,
                        (index) => const Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Puntuación
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$score',
                style: GoogleFonts.fredoka(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'puntos',
                style: GoogleFonts.fredoka(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
