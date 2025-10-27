# Arquitectura del Sistema - Videojuego Educativo Infantil

## 1. Visión General del Sistema

### 1.1 Descripción
Plataforma web educativa gamificada para niños de 6-12 años, desarrollada con Flutter Web y Firebase como backend.

### 1.2 Características Principales
- **Público objetivo**: Niños de 6-12 años
- **Plataforma**: Web (PC, tablets, móviles)
- **Tecnologías**: Dart/Flutter Web + Firebase
- **Modo**: Online con soporte offline

---

## 2. Arquitectura del Sistema

### 2.1 Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────────┐
│                   CLIENTE (Flutter Web)              │
│                                                       │
│  ┌─────────────┐  ┌──────────────┐  ┌─────────────┐ │
│  │   UI Layer  │  │  Bloc/State  │  │  Local DB   │ │
│  │  (Widgets)  │◄─┤  Management  │  │  (Hive/     │ │
│  │             │  │              │  │  SharedPref)│ │
│  └─────────────┘  └──────────────┘  └─────────────┘ │
│         │                │                  │        │
│         └────────────────┼──────────────────┘        │
│                          │                           │
│                ┌─────────▼──────────┐                │
│                │  Service Layer     │                │
│                │  (Repositories)    │                │
│                └─────────┬──────────┘                │
└──────────────────────────┼───────────────────────────┘
                           │
                           │ Firebase SDK
                           │
┌──────────────────────────▼───────────────────────────┐
│              BACKEND (Firebase)                       │
│                                                       │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │ Firebase     │  │  Firestore   │  │  Firebase  │ │
│  │ Auth         │  │  (Database)  │  │  Storage   │ │
│  └──────────────┘  └──────────────┘  └────────────┘ │
│                                                       │
│  ┌──────────────┐  ┌──────────────┐                 │
│  │ Cloud        │  │  Firebase    │                 │
│  │ Functions    │  │  Analytics   │                 │
│  └──────────────┘  └──────────────┘                 │
└───────────────────────────────────────────────────────┘
```

### 2.2 Capas del Sistema

#### **Capa de Presentación (UI Layer)**
- Widgets de Flutter optimizados para web
- Diseño responsivo (móvil, tablet, desktop)
- Animaciones fluidas y atractivas
- Temas coloridos y personalizables

#### **Capa de Lógica de Negocio (Business Logic Layer)**
- **State Management**: Flutter Bloc / Provider
- Gestión de estados del juego
- Validación de respuestas
- Cálculo de puntuaciones y recompensas

#### **Capa de Datos (Data Layer)**
- **Repositorios**: Abstracción de fuentes de datos
- **Cache Local**: Hive o SharedPreferences
- **Sincronización**: Estrategia online/offline

#### **Capa de Servicios (Services Layer)**
- Firebase Authentication Service
- Firestore Service
- Storage Service
- Analytics Service

---

## 3. Estructura de Datos en Firebase

### 3.1 Firestore Collections

#### **users**
```json
{
  "userId": "string",
  "displayName": "string",
  "avatarId": "string",
  "age": "number",
  "dateCreated": "timestamp",
  "parentEmail": "string (optional)",
  "settings": {
    "soundEnabled": "boolean",
    "musicEnabled": "boolean",
    "difficulty": "easy|medium|hard"
  }
}
```

#### **progress**
```json
{
  "userId": "string",
  "gameId": "string",
  "categoryId": "string",
  "score": "number",
  "stars": "number (1-3)",
  "completed": "boolean",
  "attempts": "number",
  "bestTime": "number",
  "lastPlayed": "timestamp"
}
```

#### **rewards**
```json
{
  "userId": "string",
  "totalPoints": "number",
  "totalStars": "number",
  "badges": ["array of badgeIds"],
  "achievements": [
    {
      "achievementId": "string",
      "unlockedAt": "timestamp"
    }
  ]
}
```

#### **games**
```json
{
  "gameId": "string",
  "name": "string",
  "categoryId": "string",
  "difficulty": "easy|medium|hard",
  "description": "string",
  "icon": "string (url)",
  "minAge": "number",
  "maxAge": "number",
  "pointsPerCorrect": "number",
  "active": "boolean"
}
```

#### **questions** (Banco educativo)
```json
{
  "questionId": "string",
  "gameId": "string",
  "categoryId": "string",
  "type": "multipleChoice|trueFalse|matching|fillBlank",
  "difficulty": "easy|medium|hard",
  "question": "string",
  "options": ["array"],
  "correctAnswer": "string or number",
  "explanation": "string",
  "imageUrl": "string (optional)",
  "audioUrl": "string (optional)"
}
```

### 3.2 Firebase Storage
```
/avatars/
  - avatar_1.png
  - avatar_2.png
  - ...

/game-assets/
  - /matematicas/
  - /lenguaje/
  - /ciencias/
  - /creatividad/

/user-creations/
  - /{userId}/
    - drawing_1.png
    - ...
```

---

## 4. Módulos del Sistema

### 4.1 Módulo de Autenticación y Usuario
- **Funcionalidades**:
  - Login/Registro simple (nombre + edad)
  - Autenticación anónima con opción de vincular email parental
  - Selección de avatar personalizado
  - Gestión de perfil de usuario

### 4.2 Módulo de Juegos
- **Categorías**:
  1. **Matemáticas**: Suma, resta, multiplicación, geometría
  2. **Lenguaje**: Vocabulario, ortografía, comprensión lectora
  3. **Ciencias**: Animales, plantas, cuerpo humano, experimentos
  4. **Creatividad**: Dibujo, música, puzzles, construcción

- **Minijuegos Base**:
  - Quiz interactivo
  - Arrastrar y soltar
  - Memoria y parejas
  - Rompecabezas
  - Completar palabras
  - Secuencias lógicas

### 4.3 Módulo de Recompensas
- **Sistema de puntos**: Por respuestas correctas y tiempo
- **Estrellas**: 1-3 estrellas según desempeño
- **Medallas**: Por hitos específicos
- **Logros desbloqueables**: Motivación continua

### 4.4 Módulo de Control Parental
- Dashboard de progreso del niño
- Configuración de tiempo de juego
- Reportes de actividad
- Gestión de privacidad

### 4.5 Módulo Educativo
- Banco de preguntas dinámico
- Adaptación de dificultad según edad y progreso
- Contenido multimedia (imágenes, audio)
- Retroalimentación educativa

---

## 5. Flujo de Usuario

```
┌─────────────┐
│   Inicio    │
└──────┬──────┘
       │
       ▼
┌─────────────────┐
│ Login/Registro  │
│ (Seleccionar    │
│  Avatar)        │
└──────┬──────────┘
       │
       ▼
┌─────────────────┐
│  Menú Principal │ ◄──────┐
│  - Mis Juegos   │        │
│  - Recompensas  │        │
│  - Mi Progreso  │        │
└──────┬──────────┘        │
       │                   │
       ▼                   │
┌─────────────────┐        │
│ Seleccionar     │        │
│ Categoría       │        │
└──────┬──────────┘        │
       │                   │
       ▼                   │
┌─────────────────┐        │
│ Seleccionar     │        │
│ Minijuego       │        │
└──────┬──────────┘        │
       │                   │
       ▼                   │
┌─────────────────┐        │
│  Jugar          │        │
│  (Interacción)  │        │
└──────┬──────────┘        │
       │                   │
       ▼                   │
┌─────────────────┐        │
│  Resultados     │        │
│  + Recompensas  │        │
└──────┬──────────┘        │
       │                   │
       └───────────────────┘
```

---

## 6. Características Técnicas Clave

### 6.1 Modo Offline
- **Cache local** con Hive para:
  - Datos de usuario
  - Progreso reciente
  - Preguntas descargadas
- **Sincronización automática** al recuperar conexión
- **Cola de operaciones** pendientes

### 6.2 Seguridad y Privacidad
- Autenticación segura con Firebase Auth
- Reglas de seguridad en Firestore
- No recolección de datos personales sensibles
- Cumplimiento COPPA (Children's Online Privacy Protection Act)
- Encriptación de datos en tránsito y reposo

### 6.3 Rendimiento
- Lazy loading de recursos
- Caché de imágenes y assets
- Optimización de consultas Firestore
- Precarga de niveles próximos

### 6.4 Escalabilidad
- Arquitectura modular para agregar juegos
- Sistema de plugins para nuevas categorías
- Configuración basada en JSON
- Contenido dinámico desde Firestore

---

## 7. Estrategia de Desarrollo

### 7.1 Fases del Proyecto

**Fase 1: MVP (Minimum Viable Product)**
- Autenticación básica
- 1 categoría con 3 minijuegos
- Sistema básico de puntos
- Perfil de usuario simple

**Fase 2: Expansión**
- 4 categorías completas
- Sistema de recompensas completo
- Control parental
- Modo offline

**Fase 3: Mejoras**
- Más minijuegos
- Análisis de aprendizaje
- Multiplayer (opcional)
- Personalización avanzada

### 7.2 Stack Tecnológico Recomendado

**Frontend**:
- Flutter Web 3.x
- flutter_bloc (state management)
- go_router (navegación)
- hive (cache local)
- cached_network_image

**Backend**:
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Cloud Functions (opcional para lógica compleja)
- Firebase Analytics

**Desarrollo**:
- VS Code / Android Studio
- Firebase CLI
- Git para control de versiones

---

## 8. Consideraciones de UX para Niños

### 8.1 Diseño Visual
- **Colores vibrantes** pero no saturados
- **Tipografía grande** y legible (Comic Sans, Fredoka, Bubblegum)
- **Iconos grandes** y reconocibles
- **Animaciones suaves** y gratificantes
- **Feedback visual y sonoro** constante

### 8.2 Interacción
- **Toques grandes** (mínimo 44x44 pts)
- **Instrucciones por voz** opcional
- **Guía animado** (mascota/avatar)
- **Navegación simple** (máximo 3 niveles)
- **Confirmaciones visuales** de acciones

### 8.3 Motivación
- **Refuerzo positivo** constante
- **Celebración de logros** con animaciones
- **Progreso visible** (barras, estrellas)
- **Variedad** en actividades
- **Dificultad adaptativa**

---

## 9. Métricas y Analytics

### 9.1 KPIs a Monitorear
- Tiempo promedio de sesión
- Tasa de completación de juegos
- Progreso educativo por categoría
- Retención de usuarios (D1, D7, D30)
- Juegos más populares
- Puntos de abandono

### 9.2 Analytics para Padres
- Horas jugadas por día/semana
- Áreas de fortaleza/mejora
- Logros alcanzados
- Progreso comparado con grupo de edad

---

## 10. Roadmap de Funcionalidades Futuras

- [ ] Modo multijugador (competencias amistosas)
- [ ] Sistema de amigos (con aprobación parental)
- [ ] Contenido generado por IA adaptado al nivel
- [ ] Integración con currículo escolar
- [ ] App móvil nativa (iOS/Android)
- [ ] Modo historia/aventura
- [ ] Creador de contenido para educadores
- [ ] Exportación de reportes PDF para padres
