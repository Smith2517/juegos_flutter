# Ejemplos de Código Base - Flutter Web + Firebase

## 1. Configuración Inicial

### 1.1 pubspec.yaml

```yaml
name: videojuego_educativo
description: Plataforma educativa gamificada para niños de 6-12 años
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # Firebase
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  cloud_firestore: ^4.13.0
  firebase_storage: ^11.5.0
  firebase_analytics: ^10.7.0

  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5

  # Routing
  go_router: ^12.1.1

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.2.2

  # Network
  connectivity_plus: ^5.0.2
  internet_connection_checker: ^1.0.0+1

  # UI & Animations
  cached_network_image: ^3.3.0
  lottie: ^2.7.0
  flutter_animate: ^4.3.0
  confetti: ^0.7.0
  shimmer: ^3.0.0

  # Audio
  audioplayers: ^5.2.1
  just_audio: ^0.9.36

  # Utils
  intl: ^0.18.1
  uuid: ^4.2.2
  dartz: ^0.10.1
  get_it: ^7.6.4
  logger: ^2.0.2+1

  # Icons & Fonts
  flutter_svg: ^2.0.9
  google_fonts: ^6.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  hive_generator: ^2.0.1
  build_runner: ^2.4.7
  mockito: ^5.4.4
  bloc_test: ^9.1.5

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/images/avatars/
    - assets/images/backgrounds/
    - assets/images/icons/
    - assets/images/characters/
    - assets/images/rewards/
    - assets/sounds/
    - assets/animations/

  fonts:
    - family: Fredoka
      fonts:
        - asset: assets/fonts/Fredoka-Regular.ttf
        - asset: assets/fonts/Fredoka-Bold.ttf
          weight: 700
    - family: ComicNeue
      fonts:
        - asset: assets/fonts/ComicNeue-Regular.ttf
```

---

## 2. Modelos de Datos

### 2.1 User Model

```dart
// lib/data/models/user_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String displayName;
  final String avatarId;
  final int age;
  final DateTime dateCreated;
  final String? parentEmail;
  final UserSettings settings;

  const UserModel({
    required this.userId,
    required this.displayName,
    required this.avatarId,
    required this.age,
    required this.dateCreated,
    this.parentEmail,
    required this.settings,
  });

  // From JSON (Firestore)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      avatarId: json['avatarId'] as String,
      age: json['age'] as int,
      dateCreated: (json['dateCreated'] as Timestamp).toDate(),
      parentEmail: json['parentEmail'] as String?,
      settings: UserSettings.fromJson(json['settings'] as Map<String, dynamic>),
    );
  }

  // To JSON (Firestore)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'avatarId': avatarId,
      'age': age,
      'dateCreated': Timestamp.fromDate(dateCreated),
      'parentEmail': parentEmail,
      'settings': settings.toJson(),
    };
  }

  // CopyWith
  UserModel copyWith({
    String? userId,
    String? displayName,
    String? avatarId,
    int? age,
    DateTime? dateCreated,
    String? parentEmail,
    UserSettings? settings,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      avatarId: avatarId ?? this.avatarId,
      age: age ?? this.age,
      dateCreated: dateCreated ?? this.dateCreated,
      parentEmail: parentEmail ?? this.parentEmail,
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        displayName,
        avatarId,
        age,
        dateCreated,
        parentEmail,
        settings,
      ];
}

class UserSettings extends Equatable {
  final bool soundEnabled;
  final bool musicEnabled;
  final String difficulty;

  const UserSettings({
    this.soundEnabled = true,
    this.musicEnabled = true,
    this.difficulty = 'easy',
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      musicEnabled: json['musicEnabled'] as bool? ?? true,
      difficulty: json['difficulty'] as String? ?? 'easy',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'soundEnabled': soundEnabled,
      'musicEnabled': musicEnabled,
      'difficulty': difficulty,
    };
  }

  @override
  List<Object?> get props => [soundEnabled, musicEnabled, difficulty];
}
```

### 2.2 Game Model

```dart
// lib/data/models/game_model.dart

import 'package:equatable/equatable.dart';

class GameModel extends Equatable {
  final String gameId;
  final String name;
  final String categoryId;
  final String difficulty;
  final String description;
  final String iconUrl;
  final int minAge;
  final int maxAge;
  final int pointsPerCorrect;
  final bool active;

  const GameModel({
    required this.gameId,
    required this.name,
    required this.categoryId,
    required this.difficulty,
    required this.description,
    required this.iconUrl,
    required this.minAge,
    required this.maxAge,
    required this.pointsPerCorrect,
    this.active = true,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      gameId: json['gameId'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      difficulty: json['difficulty'] as String,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      minAge: json['minAge'] as int,
      maxAge: json['maxAge'] as int,
      pointsPerCorrect: json['pointsPerCorrect'] as int,
      active: json['active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'name': name,
      'categoryId': categoryId,
      'difficulty': difficulty,
      'description': description,
      'iconUrl': iconUrl,
      'minAge': minAge,
      'maxAge': maxAge,
      'pointsPerCorrect': pointsPerCorrect,
      'active': active,
    };
  }

  @override
  List<Object?> get props => [
        gameId,
        name,
        categoryId,
        difficulty,
        description,
        iconUrl,
        minAge,
        maxAge,
        pointsPerCorrect,
        active,
      ];
}
```

### 2.3 Question Model

```dart
// lib/data/models/question_model.dart

import 'package:equatable/equatable.dart';

enum QuestionType {
  multipleChoice,
  trueFalse,
  matching,
  fillBlank,
  dragAndDrop,
}

class QuestionModel extends Equatable {
  final String questionId;
  final String gameId;
  final String categoryId;
  final QuestionType type;
  final String difficulty;
  final String question;
  final List<String> options;
  final dynamic correctAnswer;
  final String? explanation;
  final String? imageUrl;
  final String? audioUrl;

  const QuestionModel({
    required this.questionId,
    required this.gameId,
    required this.categoryId,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.explanation,
    this.imageUrl,
    this.audioUrl,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      questionId: json['questionId'] as String,
      gameId: json['gameId'] as String,
      categoryId: json['categoryId'] as String,
      type: QuestionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => QuestionType.multipleChoice,
      ),
      difficulty: json['difficulty'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'] as String?,
      imageUrl: json['imageUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'gameId': gameId,
      'categoryId': categoryId,
      'type': type.name,
      'difficulty': difficulty,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
    };
  }

  @override
  List<Object?> get props => [
        questionId,
        gameId,
        categoryId,
        type,
        difficulty,
        question,
        options,
        correctAnswer,
        explanation,
        imageUrl,
        audioUrl,
      ];
}
```

---

## 3. Firebase Services

### 3.1 Firebase Service Base

```dart
// lib/data/datasources/remote/firebase_service.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseStorage get storage => FirebaseStorage.instance;

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "YOUR_API_KEY",
        authDomain: "YOUR_AUTH_DOMAIN",
        projectId: "YOUR_PROJECT_ID",
        storageBucket: "YOUR_STORAGE_BUCKET",
        messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
        appId: "YOUR_APP_ID",
      ),
    );

    // Configurar Firestore settings
    firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }
}
```

### 3.2 Auth Repository

```dart
// lib/data/repositories/auth_repository.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  // Stream de estado de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Usuario actual
  User? get currentUser => _auth.currentUser;

  // Registro anónimo (para niños)
  Future<UserModel> registerAnonymously({
    required String displayName,
    required String avatarId,
    required int age,
  }) async {
    try {
      // Autenticación anónima
      final userCredential = await _auth.signInAnonymously();
      final uid = userCredential.user!.uid;

      // Crear modelo de usuario
      final userModel = UserModel(
        userId: uid,
        displayName: displayName,
        avatarId: avatarId,
        age: age,
        dateCreated: DateTime.now(),
        settings: const UserSettings(),
      );

      // Guardar en Firestore
      await _firestore.collection('users').doc(uid).set(userModel.toJson());

      return userModel;
    } catch (e) {
      throw Exception('Error al registrar usuario: $e');
    }
  }

  // Vincular email parental
  Future<void> linkParentalEmail(String email, String password) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await currentUser?.linkWithCredential(credential);
    } catch (e) {
      throw Exception('Error al vincular email: $e');
    }
  }

  // Obtener datos de usuario
  Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener usuario: $e');
    }
  }

  // Actualizar usuario
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

  // Cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
```

### 3.3 Game Repository

```dart
// lib/data/repositories/game_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/game_model.dart';
import '../models/question_model.dart';

class GameRepository {
  final FirebaseFirestore _firestore;

  GameRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Obtener juegos por categoría
  Future<List<GameModel>> getGamesByCategory(String categoryId) async {
    try {
      final snapshot = await _firestore
          .collection('games')
          .where('categoryId', isEqualTo: categoryId)
          .where('active', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => GameModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener juegos: $e');
    }
  }

  // Obtener todos los juegos
  Stream<List<GameModel>> getAllGames() {
    return _firestore
        .collection('games')
        .where('active', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => GameModel.fromJson(doc.data())).toList());
  }

  // Obtener preguntas para un juego
  Future<List<QuestionModel>> getQuestionsForGame({
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

      final questions = snapshot.docs
          .map((doc) => QuestionModel.fromJson(doc.data()))
          .toList();

      // Mezclar preguntas
      questions.shuffle();
      return questions;
    } catch (e) {
      throw Exception('Error al obtener preguntas: $e');
    }
  }
}
```

### 3.4 Progress Repository

```dart
// lib/data/repositories/progress_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/progress_model.dart';

class ProgressRepository {
  final FirebaseFirestore _firestore;

  ProgressRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Guardar progreso
  Future<void> saveProgress(ProgressModel progress) async {
    try {
      final docId = '${progress.userId}_${progress.gameId}';
      await _firestore
          .collection('progress')
          .doc(docId)
          .set(progress.toJson(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error al guardar progreso: $e');
    }
  }

  // Obtener progreso de usuario
  Stream<List<ProgressModel>> getUserProgress(String userId) {
    return _firestore
        .collection('progress')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProgressModel.fromJson(doc.data()))
            .toList());
  }

  // Obtener progreso específico de un juego
  Future<ProgressModel?> getGameProgress(String userId, String gameId) async {
    try {
      final docId = '${userId}_$gameId';
      final doc = await _firestore.collection('progress').doc(docId).get();

      if (doc.exists) {
        return ProgressModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener progreso: $e');
    }
  }
}

// lib/data/models/progress_model.dart
class ProgressModel {
  final String userId;
  final String gameId;
  final String categoryId;
  final int score;
  final int stars;
  final bool completed;
  final int attempts;
  final int? bestTime;
  final DateTime lastPlayed;

  const ProgressModel({
    required this.userId,
    required this.gameId,
    required this.categoryId,
    required this.score,
    required this.stars,
    required this.completed,
    required this.attempts,
    this.bestTime,
    required this.lastPlayed,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      userId: json['userId'] as String,
      gameId: json['gameId'] as String,
      categoryId: json['categoryId'] as String,
      score: json['score'] as int,
      stars: json['stars'] as int,
      completed: json['completed'] as bool,
      attempts: json['attempts'] as int,
      bestTime: json['bestTime'] as int?,
      lastPlayed: (json['lastPlayed'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'gameId': gameId,
      'categoryId': categoryId,
      'score': score,
      'stars': stars,
      'completed': completed,
      'attempts': attempts,
      'bestTime': bestTime,
      'lastPlayed': Timestamp.fromDate(lastPlayed),
    };
  }
}
```

---

## 4. State Management (BLoC)

### 4.1 Auth BLoC

```dart
// lib/presentation/bloc/auth/auth_event.dart
abstract class AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String displayName;
  final String avatarId;
  final int age;

  AuthLoginRequested({
    required this.displayName,
    required this.avatarId,
    required this.age,
  });
}

class AuthLogoutRequested extends AuthEvent {}

// lib/presentation/bloc/auth/auth_state.dart
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated(this.user);
}
class AuthUnauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// lib/presentation/bloc/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = _authRepository.currentUser;
      if (user != null) {
        final userData = await _authRepository.getUserData(user.uid);
        if (userData != null) {
          emit(AuthAuthenticated(userData));
        } else {
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.registerAnonymously(
        displayName: event.displayName,
        avatarId: event.avatarId,
        age: event.age,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError('Error al iniciar sesión: $e'));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signOut();
    emit(AuthUnauthenticated());
  }
}
```

---

## 5. UI Screens

### 5.1 Login Screen

```dart
// lib/presentation/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  int _selectedAge = 6;
  String _selectedAvatar = 'avatar_1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Título
                      Text(
                        '¡Bienvenido!',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: const Color(0xFF4A90E2),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Vamos a conocerte',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 32),

                      // Campo de nombre
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: '¿Cómo te llamas?',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 24),

                      // Selector de edad
                      Text(
                        '¿Cuántos años tienes?',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        children: List.generate(7, (index) {
                          final age = index + 6;
                          return ChoiceChip(
                            label: Text('$age'),
                            selected: _selectedAge == age,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() => _selectedAge = age);
                              }
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 24),

                      // Selector de avatar
                      Text(
                        'Elige tu avatar',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            final avatarId = 'avatar_${index + 1}';
                            return GestureDetector(
                              onTap: () => setState(() => _selectedAvatar = avatarId),
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _selectedAvatar == avatarId
                                        ? const Color(0xFF4A90E2)
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                    'assets/images/avatars/$avatarId.png',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Botón de inicio
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthAuthenticated) {
                            // Navegar al home
                            Navigator.of(context).pushReplacementNamed('/home');
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;
                          return ElevatedButton(
                            onPressed: isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4A90E2),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    '¡Empezar a Jugar!',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa tu nombre')),
      );
      return;
    }

    context.read<AuthBloc>().add(
          AuthLoginRequested(
            displayName: name,
            avatarId: _selectedAvatar,
            age: _selectedAge,
          ),
        );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
```

---

## 6. Main Entry Point

```dart
// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/datasources/remote/firebase_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/game_repository.dart';
import 'data/repositories/progress_repository.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await FirebaseService.initialize();

  // Inicializar Hive (local storage)
  await Hive.initFlutter();

  // Ejecutar app
  runApp(const MyApp());
}

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
```

---

## 7. Firestore Security Rules

```javascript
// firestore.rules

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Helper functions
    function isAuthenticated() {
      return request.auth != null;
    }

    function isOwner(userId) {
      return request.auth.uid == userId;
    }

    // Users collection
    match /users/{userId} {
      allow read: if isAuthenticated() && isOwner(userId);
      allow create: if isAuthenticated() && isOwner(userId);
      allow update: if isAuthenticated() && isOwner(userId);
      allow delete: if false; // No permitir eliminación
    }

    // Progress collection
    match /progress/{progressId} {
      allow read: if isAuthenticated() &&
                     resource.data.userId == request.auth.uid;
      allow write: if isAuthenticated() &&
                      request.resource.data.userId == request.auth.uid;
    }

    // Rewards collection
    match /rewards/{userId} {
      allow read: if isAuthenticated() && isOwner(userId);
      allow write: if isAuthenticated() && isOwner(userId);
    }

    // Games collection (read-only)
    match /games/{gameId} {
      allow read: if isAuthenticated();
      allow write: if false; // Solo admin puede escribir
    }

    // Questions collection (read-only)
    match /questions/{questionId} {
      allow read: if isAuthenticated();
      allow write: if false; // Solo admin puede escribir
    }
  }
}
```

---

## 8. Pasos Siguientes

1. **Configurar proyecto Flutter**:
   ```bash
   flutter create --platforms=web videojuego_educativo
   cd videojuego_educativo
   ```

2. **Configurar Firebase**:
   ```bash
   firebase login
   firebase init
   ```

3. **Copiar `pubspec.yaml`** y ejecutar:
   ```bash
   flutter pub get
   ```

4. **Crear estructura de carpetas** según lo definido

5. **Implementar modelos, repositorios y BLoCs**

6. **Diseñar y crear assets** (imágenes, sonidos, fuentes)

7. **Desarrollar pantallas principales**

8. **Implementar minijuegos**

9. **Testing**

10. **Deploy**:
    ```bash
    flutter build web
    firebase deploy
    ```
