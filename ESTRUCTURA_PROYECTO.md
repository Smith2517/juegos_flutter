# Estructura del Proyecto Flutter Web - Videojuego Educativo

## Estructura de Carpetas Completa

```
videojuego_educativo/
│
├── lib/
│   ├── main.dart                          # Punto de entrada de la app
│   │
│   ├── app/
│   │   ├── app.dart                       # Widget raíz de la aplicación
│   │   ├── routes.dart                    # Configuración de rutas
│   │   └── theme/
│   │       ├── app_theme.dart            # Tema principal
│   │       ├── colors.dart               # Paleta de colores
│   │       ├── text_styles.dart          # Estilos de texto
│   │       └── animations.dart           # Animaciones reutilizables
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_constants.dart        # Constantes globales
│   │   │   ├── game_constants.dart       # Constantes de juego
│   │   │   └── storage_keys.dart         # Keys para storage
│   │   │
│   │   ├── errors/
│   │   │   ├── failures.dart             # Clases de errores
│   │   │   └── exceptions.dart           # Excepciones personalizadas
│   │   │
│   │   ├── utils/
│   │   │   ├── validators.dart           # Validadores
│   │   │   ├── helpers.dart              # Funciones auxiliares
│   │   │   ├── date_utils.dart           # Utilidades de fecha
│   │   │   └── audio_utils.dart          # Utilidades de audio
│   │   │
│   │   └── network/
│   │       ├── network_info.dart         # Detección de conectividad
│   │       └── sync_manager.dart         # Sincronización offline/online
│   │
│   ├── data/
│   │   ├── models/
│   │   │   ├── user_model.dart           # Modelo de usuario
│   │   │   ├── game_model.dart           # Modelo de juego
│   │   │   ├── progress_model.dart       # Modelo de progreso
│   │   │   ├── reward_model.dart         # Modelo de recompensas
│   │   │   ├── question_model.dart       # Modelo de preguntas
│   │   │   └── achievement_model.dart    # Modelo de logros
│   │   │
│   │   ├── repositories/
│   │   │   ├── auth_repository.dart      # Repositorio de autenticación
│   │   │   ├── user_repository.dart      # Repositorio de usuarios
│   │   │   ├── game_repository.dart      # Repositorio de juegos
│   │   │   ├── progress_repository.dart  # Repositorio de progreso
│   │   │   ├── reward_repository.dart    # Repositorio de recompensas
│   │   │   └── question_repository.dart  # Repositorio de preguntas
│   │   │
│   │   └── datasources/
│   │       ├── local/
│   │       │   ├── local_storage.dart    # Storage local (Hive)
│   │       │   ├── user_local_ds.dart    # Data source local de usuario
│   │       │   └── cache_manager.dart    # Gestor de caché
│   │       │
│   │       └── remote/
│   │           ├── firebase_service.dart  # Servicio base de Firebase
│   │           ├── auth_remote_ds.dart    # Data source remoto de auth
│   │           ├── firestore_service.dart # Servicio de Firestore
│   │           └── storage_service.dart   # Servicio de Storage
│   │
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── user.dart                 # Entidad de usuario
│   │   │   ├── game.dart                 # Entidad de juego
│   │   │   ├── progress.dart             # Entidad de progreso
│   │   │   ├── reward.dart               # Entidad de recompensas
│   │   │   └── question.dart             # Entidad de preguntas
│   │   │
│   │   └── use_cases/
│   │       ├── auth/
│   │       │   ├── login_user.dart       # Caso de uso: Login
│   │       │   └── register_user.dart    # Caso de uso: Registro
│   │       │
│   │       ├── game/
│   │       │   ├── get_games.dart        # Obtener juegos
│   │       │   ├── play_game.dart        # Jugar juego
│   │       │   └── submit_answer.dart    # Enviar respuesta
│   │       │
│   │       └── progress/
│   │           ├── save_progress.dart    # Guardar progreso
│   │           └── get_user_stats.dart   # Obtener estadísticas
│   │
│   ├── presentation/
│   │   ├── bloc/                         # State management (BLoC)
│   │   │   ├── auth/
│   │   │   │   ├── auth_bloc.dart
│   │   │   │   ├── auth_event.dart
│   │   │   │   └── auth_state.dart
│   │   │   │
│   │   │   ├── game/
│   │   │   │   ├── game_bloc.dart
│   │   │   │   ├── game_event.dart
│   │   │   │   └── game_state.dart
│   │   │   │
│   │   │   ├── progress/
│   │   │   │   ├── progress_bloc.dart
│   │   │   │   ├── progress_event.dart
│   │   │   │   └── progress_state.dart
│   │   │   │
│   │   │   └── rewards/
│   │   │       ├── rewards_bloc.dart
│   │   │       ├── rewards_event.dart
│   │   │       └── rewards_state.dart
│   │   │
│   │   ├── screens/
│   │   │   ├── splash/
│   │   │   │   └── splash_screen.dart
│   │   │   │
│   │   │   ├── auth/
│   │   │   │   ├── login_screen.dart
│   │   │   │   └── avatar_selection_screen.dart
│   │   │   │
│   │   │   ├── home/
│   │   │   │   ├── home_screen.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── category_card.dart
│   │   │   │       ├── guide_avatar.dart
│   │   │   │       └── stats_widget.dart
│   │   │   │
│   │   │   ├── games/
│   │   │   │   ├── game_selection_screen.dart
│   │   │   │   ├── game_screen.dart
│   │   │   │   ├── results_screen.dart
│   │   │   │   │
│   │   │   │   └── mini_games/
│   │   │   │       ├── math/
│   │   │   │       │   ├── addition_game.dart
│   │   │   │       │   ├── subtraction_game.dart
│   │   │   │       │   └── geometry_game.dart
│   │   │   │       │
│   │   │   │       ├── language/
│   │   │   │       │   ├── vocabulary_game.dart
│   │   │   │       │   ├── spelling_game.dart
│   │   │   │       │   └── reading_game.dart
│   │   │   │       │
│   │   │   │       ├── science/
│   │   │   │       │   ├── animals_game.dart
│   │   │   │       │   └── body_game.dart
│   │   │   │       │
│   │   │   │       └── creativity/
│   │   │   │           ├── drawing_game.dart
│   │   │   │           └── puzzle_game.dart
│   │   │   │
│   │   │   ├── profile/
│   │   │   │   ├── profile_screen.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── avatar_display.dart
│   │   │   │       └── progress_chart.dart
│   │   │   │
│   │   │   ├── rewards/
│   │   │   │   ├── rewards_screen.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── badge_card.dart
│   │   │   │       └── achievement_list.dart
│   │   │   │
│   │   │   └── parental/
│   │   │       ├── parental_dashboard.dart
│   │   │       └── parental_settings.dart
│   │   │
│   │   └── widgets/
│   │       ├── common/
│   │       │   ├── custom_button.dart
│   │       │   ├── loading_indicator.dart
│   │       │   ├── error_widget.dart
│   │       │   ├── star_rating.dart
│   │       │   └── confetti_animation.dart
│   │       │
│   │       ├── game_components/
│   │       │   ├── question_card.dart
│   │       │   ├── answer_option.dart
│   │       │   ├── timer_widget.dart
│   │       │   ├── score_display.dart
│   │       │   └── lives_display.dart
│   │       │
│   │       └── animations/
│   │           ├── character_animations.dart
│   │           ├── celebration_animation.dart
│   │           └── transition_animations.dart
│   │
│   └── services/
│       ├── audio_service.dart            # Servicio de audio
│       ├── analytics_service.dart        # Servicio de analytics
│       ├── notification_service.dart     # Servicio de notificaciones
│       └── localization_service.dart     # Servicio de localización
│
├── assets/
│   ├── images/
│   │   ├── avatars/
│   │   │   ├── avatar_1.png
│   │   │   ├── avatar_2.png
│   │   │   └── ...
│   │   │
│   │   ├── backgrounds/
│   │   │   ├── home_bg.png
│   │   │   └── game_bg.png
│   │   │
│   │   ├── icons/
│   │   │   ├── math_icon.png
│   │   │   ├── language_icon.png
│   │   │   ├── science_icon.png
│   │   │   └── creativity_icon.png
│   │   │
│   │   ├── characters/
│   │   │   ├── guide_happy.png
│   │   │   ├── guide_thinking.png
│   │   │   └── guide_celebrating.png
│   │   │
│   │   └── rewards/
│   │       ├── badges/
│   │       └── stars/
│   │
│   ├── sounds/
│   │   ├── background_music.mp3
│   │   ├── correct_answer.mp3
│   │   ├── wrong_answer.mp3
│   │   ├── level_complete.mp3
│   │   └── button_click.mp3
│   │
│   ├── fonts/
│   │   ├── Fredoka-Bold.ttf
│   │   ├── Fredoka-Regular.ttf
│   │   └── ComicNeue-Regular.ttf
│   │
│   └── animations/
│       ├── confetti.json               # Lottie animation
│       └── celebration.json
│
├── web/
│   ├── index.html
│   ├── manifest.json
│   ├── favicon.png
│   └── icons/
│
├── test/
│   ├── unit/
│   │   ├── repositories/
│   │   └── use_cases/
│   │
│   ├── widget/
│   │   └── screens/
│   │
│   └── integration/
│       └── flows/
│
├── pubspec.yaml                        # Dependencias del proyecto
├── analysis_options.yaml               # Reglas de análisis
├── .env                                # Variables de entorno
├── firebase.json                       # Configuración de Firebase
├── firestore.rules                     # Reglas de seguridad Firestore
├── storage.rules                       # Reglas de seguridad Storage
└── README.md
```

---

## Descripción de Módulos Principales

### 1. **Core** (`lib/core/`)
Contiene toda la lógica compartida, utilidades y configuraciones base:
- **constants/**: Valores constantes usados en toda la app
- **errors/**: Manejo centralizado de errores
- **utils/**: Funciones auxiliares y helpers
- **network/**: Detección de conectividad y sincronización

### 2. **Data** (`lib/data/`)
Capa de datos con patrón Repository:
- **models/**: Modelos de datos (JSON serialization)
- **repositories/**: Implementación de repositorios (contratos con domain)
- **datasources/**: Fuentes de datos (local/remote)

### 3. **Domain** (`lib/domain/`)
Lógica de negocio pura:
- **entities/**: Entidades de dominio (sin dependencias externas)
- **use_cases/**: Casos de uso específicos del negocio

### 4. **Presentation** (`lib/presentation/`)
Capa de presentación con UI:
- **bloc/**: State management con BLoC pattern
- **screens/**: Pantallas de la aplicación
- **widgets/**: Widgets reutilizables

### 5. **Services** (`lib/services/`)
Servicios transversales:
- Audio, analytics, notificaciones, localización

---

## Convenciones de Nombres

### Archivos
- **Lowercase con guiones bajos**: `user_repository.dart`
- **Sufijos descriptivos**: `*_screen.dart`, `*_widget.dart`, `*_bloc.dart`

### Clases
- **PascalCase**: `UserRepository`, `AuthBloc`
- **Descriptivas y específicas**: `AdditionGameScreen` vs `GameScreen`

### Variables y Funciones
- **camelCase**: `getUserProgress()`, `currentScore`
- **Descriptivas**: `isGameCompleted` vs `flag`

### Constantes
- **lowerCamelCase o UPPER_CASE** según contexto:
  ```dart
  const int maxAttempts = 3;
  const String DEFAULT_AVATAR = 'avatar_1';
  ```

---

## Principios de Arquitectura

### 1. **Clean Architecture**
- Separación clara entre capas
- Dependencias apuntan hacia adentro
- Domain layer independiente de frameworks

### 2. **SOLID Principles**
- **S**ingle Responsibility: Cada clase una responsabilidad
- **O**pen/Closed: Abierto para extensión, cerrado para modificación
- **L**iskov Substitution: Abstracciones intercambiables
- **I**nterface Segregation: Interfaces específicas
- **D**ependency Inversion: Depender de abstracciones

### 3. **Repository Pattern**
- Abstracción de fuentes de datos
- Facilita testing y cambio de implementación

### 4. **BLoC Pattern**
- Separación de lógica y UI
- Streams para manejo de estados
- Testeable y reutilizable

---

## Flujo de Datos

```
┌─────────────┐
│  UI Widget  │
└──────┬──────┘
       │ Dispara Event
       ▼
┌─────────────┐
│    BLoC     │
└──────┬──────┘
       │ Llama Use Case
       ▼
┌─────────────┐
│  Use Case   │
└──────┬──────┘
       │ Llama Repository
       ▼
┌─────────────┐
│ Repository  │
└──────┬──────┘
       │ Obtiene datos
       ▼
┌─────────────┐     ┌─────────────┐
│   Remote    │     │    Local    │
│ Data Source │     │ Data Source │
└─────────────┘     └─────────────┘
```

---

## Gestión de Estados

### Estados Comunes
```dart
abstract class GameState {}

class GameInitial extends GameState {}
class GameLoading extends GameState {}
class GameLoaded extends GameState {
  final Game game;
  final List<Question> questions;
}
class GamePlaying extends GameState {
  final int currentQuestion;
  final int score;
  final int lives;
}
class GameCompleted extends GameState {
  final int finalScore;
  final int stars;
  final List<Reward> rewards;
}
class GameError extends GameState {
  final String message;
}
```

---

## Modularización y Escalabilidad

### Agregar Nuevo Minijuego
1. Crear carpeta en `presentation/screens/games/mini_games/[categoria]/`
2. Implementar screen del juego
3. Agregar configuración en `game_constants.dart`
4. Registrar ruta en `routes.dart`
5. Crear preguntas/contenido en Firestore
6. Añadir assets necesarios

### Agregar Nueva Categoría
1. Actualizar enum de categorías en `constants/`
2. Crear subcarpeta en `mini_games/`
3. Diseñar icono y assets
4. Configurar en Firebase
5. Actualizar UI de selección de categorías

---

## Testing

### Estructura de Tests
```
test/
├── unit/
│   ├── bloc/
│   ├── repositories/
│   └── use_cases/
│
├── widget/
│   └── screens/
│
└── integration/
    └── user_flows/
```

### Tipos de Tests
- **Unit**: Lógica de negocio, use cases, repositories
- **Widget**: Componentes de UI
- **Integration**: Flujos completos de usuario

---

## Buenas Prácticas

### 1. **Código Limpio**
- Funciones pequeñas y enfocadas
- Nombres descriptivos
- Comentarios solo cuando sea necesario
- Evitar magic numbers

### 2. **Manejo de Errores**
- Try-catch en operaciones asíncronas
- Mensajes de error amigables para niños
- Logging para debugging

### 3. **Performance**
- Lazy loading de recursos
- Dispose de controllers y streams
- Optimización de imágenes
- Caché inteligente

### 4. **Accesibilidad**
- Semantics para screen readers
- Contraste de colores adecuado
- Tamaños de fuente ajustables
- Navegación por teclado

### 5. **Internacionalización**
- Strings externalizados
- Soporte multi-idioma desde el inicio
- Formatos de fecha/hora localizados

---

## Checklist de Desarrollo

- [ ] Configurar proyecto Flutter Web
- [ ] Integrar Firebase (Auth, Firestore, Storage)
- [ ] Implementar sistema de autenticación
- [ ] Crear modelos de datos
- [ ] Desarrollar repositorios
- [ ] Implementar BLoCs principales
- [ ] Diseñar y crear UI screens
- [ ] Desarrollar minijuegos (MVP)
- [ ] Implementar sistema de recompensas
- [ ] Agregar audio y animaciones
- [ ] Configurar modo offline
- [ ] Implementar control parental
- [ ] Testing exhaustivo
- [ ] Optimización de performance
- [ ] Deploy a Firebase Hosting
