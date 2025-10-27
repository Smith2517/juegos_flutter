# 🎮 Videojuego Educativo Infantil - Plataforma Web

> Plataforma educativa gamificada para niños de 6-12 años desarrollada con Flutter Web y Firebase

---

## 📋 Descripción del Proyecto

Sistema de videojuegos educativos diseñado específicamente para niños en edad escolar, con enfoque en aprendizaje divertido y seguro. La plataforma ofrece minijuegos organizados en cuatro categorías principales: Matemáticas, Lenguaje, Ciencias y Creatividad.

### 🎯 Objetivos

- Hacer del aprendizaje una experiencia divertida y motivadora
- Proporcionar un entorno seguro y apropiado para niños
- Permitir seguimiento de progreso para padres y educadores
- Fomentar el desarrollo integral (cognitivo, motor, emocional)
- Ofrecer contenido educativo de calidad adaptado a diferentes edades

---

## 🚀 Características Principales

### Para Niños
- ✨ Interfaz colorida e intuitiva
- 🎭 Avatar personalizable y guía virtual
- 🏆 Sistema de recompensas (puntos, estrellas, medallas)
- 🎮 12+ minijuegos educativos
- 📱 Responsive (PC, tablet, móvil)
- 🔊 Soporte de audio para instrucciones
- 🎨 Múltiples temas visuales

### Para Padres
- 📊 Dashboard de progreso
- 📈 Reportes educativos detallados
- ⚙️ Control parental
- 🔒 Gestión de privacidad
- 📧 Notificaciones configurables
- ⏱️ Control de tiempo de juego

### Técnicas
- 🌐 Funciona en modo offline con sincronización
- 🔥 Backend Firebase (Auth, Firestore, Storage)
- 🎯 Arquitectura limpia y escalable
- 🧩 Sistema modular para agregar contenido
- 🔐 Seguridad y privacidad COPPA-compliant
- 📊 Analytics integrado

---

## 🏗️ Arquitectura del Sistema

```
┌─────────────────────┐
│   Flutter Web       │
│   (Frontend)        │
│                     │
│  - UI/UX Infantil   │
│  - State Management │
│  - Local Cache      │
└──────────┬──────────┘
           │
           │ Firebase SDK
           │
┌──────────▼──────────┐
│   Firebase          │
│   (Backend)         │
│                     │
│  - Auth             │
│  - Firestore        │
│  - Storage          │
│  - Analytics        │
└─────────────────────┘
```

### Stack Tecnológico

**Frontend:**
- Dart / Flutter Web 3.x
- flutter_bloc (State Management)
- go_router (Navegación)
- Hive (Cache local)
- Lottie (Animaciones)

**Backend:**
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Firebase Analytics
- Cloud Functions (opcional)

**Desarrollo:**
- VS Code / Android Studio
- Firebase CLI
- Git

---

## 📁 Estructura del Proyecto

```
videojuego_educativo/
├── lib/
│   ├── app/                    # Configuración de la app
│   ├── core/                   # Utilidades y constantes
│   ├── data/                   # Modelos y repositorios
│   ├── domain/                 # Entidades y casos de uso
│   ├── presentation/           # UI y BLoC
│   │   ├── bloc/
│   │   ├── screens/
│   │   └── widgets/
│   └── services/               # Servicios transversales
├── assets/                     # Imágenes, sonidos, fuentes
├── test/                       # Tests unitarios e integración
├── web/                        # Archivos web
├── pubspec.yaml
└── README.md
```

Ver [ESTRUCTURA_PROYECTO.md](ESTRUCTURA_PROYECTO.md) para detalles completos.

---

## 🎮 Categorías de Juegos

### 📐 Matemáticas
- Suma Aventurera (6-8 años)
- Constructor de Formas (7-10 años)
- Tabla Pirata (8-12 años)

### 📚 Lenguaje
- Cazador de Palabras (6-8 años)
- Constructor de Oraciones (9-11 años)
- Detectives de Ortografía (10-12 años)

### 🔬 Ciencias
- Safari Animal (6-9 años)
- Laboratorio Divertido (8-11 años)
- Viaje por el Cuerpo (9-12 años)

### 🎨 Creatividad
- Estudio de Arte (6-10 años)
- Rompecabezas Maestro (7-12 años)
- Compositor Musical (8-12 años)

Ver [MECANICAS_JUEGO.md](MECANICAS_JUEGO.md) para descripciones completas.

---

## 🛠️ Instalación y Configuración

### Prerrequisitos

- Flutter 3.0 o superior
- Dart SDK
- Firebase CLI
- Cuenta de Firebase
- Git

### Paso 1: Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/videojuego-educativo.git
cd videojuego-educativo
```

### Paso 2: Instalar dependencias

```bash
flutter pub get
```

### Paso 3: Configurar Firebase

1. Crear proyecto en [Firebase Console](https://console.firebase.google.com/)

2. Habilitar servicios:
   - Authentication (Anonymous + Email/Password)
   - Cloud Firestore
   - Firebase Storage
   - Analytics

3. Instalar Firebase CLI:
```bash
npm install -g firebase-tools
firebase login
```

4. Inicializar Firebase en el proyecto:
```bash
firebase init
```

5. Copiar configuración de Firebase a `lib/data/datasources/remote/firebase_service.dart`

### Paso 4: Configurar Firestore

Subir reglas de seguridad:
```bash
firebase deploy --only firestore:rules
```

Importar datos iniciales (juegos, preguntas):
```bash
# Ver scripts en /scripts/seed_database.dart
dart run scripts/seed_database.dart
```

### Paso 5: Ejecutar la aplicación

**Modo desarrollo:**
```bash
flutter run -d chrome
```

**Build para producción:**
```bash
flutter build web
firebase deploy --only hosting
```

---

## 🧪 Testing

### Tests Unitarios
```bash
flutter test test/unit/
```

### Tests de Widgets
```bash
flutter test test/widget/
```

### Tests de Integración
```bash
flutter test test/integration/
```

### Cobertura
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

---

## 📊 Configuración de Firebase

### Firestore Collections

#### `users`
```json
{
  "userId": "string",
  "displayName": "string",
  "avatarId": "string",
  "age": "number",
  "dateCreated": "timestamp"
}
```

#### `games`
```json
{
  "gameId": "string",
  "name": "string",
  "categoryId": "string",
  "difficulty": "easy|medium|hard"
}
```

#### `progress`
```json
{
  "userId": "string",
  "gameId": "string",
  "score": "number",
  "stars": "number",
  "completed": "boolean"
}
```

Ver [ARQUITECTURA.md](ARQUITECTURA.md) para esquemas completos.

---

## 🔐 Seguridad y Privacidad

### Medidas Implementadas

✅ Autenticación anónima por defecto
✅ Reglas de seguridad Firestore
✅ Sin recolección de datos personales sensibles
✅ Control parental opcional
✅ Cumplimiento COPPA
✅ Encriptación de datos
✅ Sin anuncios inapropiados
✅ Contenido moderado

### Reglas de Firestore

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }

    match /progress/{progressId} {
      allow read, write: if request.auth != null &&
                            request.resource.data.userId == request.auth.uid;
    }

    match /games/{gameId} {
      allow read: if request.auth != null;
      allow write: if false; // Solo admin
    }
  }
}
```

---

## 🎨 Guía de Estilo

### Paleta de Colores

```dart
// Colores primarios
primary: Color(0xFF4A90E2)      // Azul brillante
secondary: Color(0xFF50E3C2)    // Verde agua
accent: Color(0xFFF5A623)       // Naranja cálido

// Categorías
math: Color(0xFF5C6AC4)         // Púrpura
language: Color(0xFFE74C3C)     // Rojo
science: Color(0xFF2ECC71)      // Verde
creativity: Color(0xFFF39C12)   // Amarillo
```

### Tipografía

- **Títulos**: Fredoka Bold (24-32pt)
- **Subtítulos**: Fredoka Regular (18-22pt)
- **Cuerpo**: Comic Neue Regular (14-16pt)
- **Botones**: Fredoka Bold (16-18pt)

### Espaciado

```dart
tiny: 4.0
small: 8.0
medium: 16.0
large: 24.0
xlarge: 32.0
```

---

## 🚀 Roadmap

### Fase 1: MVP (2-3 meses) ✅
- [x] Arquitectura base
- [x] Sistema de autenticación
- [x] 3 minijuegos por categoría
- [x] Sistema básico de recompensas
- [x] Perfil de usuario

### Fase 2: Expansión (3-4 meses) 🔄
- [ ] 12+ minijuegos completos
- [ ] Control parental completo
- [ ] Sistema de logros avanzado
- [ ] Modo offline funcional
- [ ] Dashboard de padres

### Fase 3: Mejoras (Ongoing) 📅
- [ ] Más categorías educativas
- [ ] Modo multijugador
- [ ] Análisis de aprendizaje con IA
- [ ] App móvil nativa
- [ ] Integración con sistemas escolares
- [ ] Modo historia/aventura

---

## 📚 Documentación Adicional

- [Arquitectura del Sistema](ARQUITECTURA.md)
- [Estructura del Proyecto](ESTRUCTURA_PROYECTO.md)
- [Ejemplos de Código](EJEMPLOS_CODIGO.md)
- [Mecánicas de Juego](MECANICAS_JUEGO.md)

---

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### Guías de Contribución

- Seguir la estructura de carpetas establecida
- Escribir tests para nuevas funcionalidades
- Documentar código adecuadamente
- Respetar las guías de estilo
- Probar en múltiples navegadores

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver archivo [LICENSE](LICENSE) para detalles.

---

## 👥 Equipo

**Desarrolladores:**
- [Tu Nombre] - Desarrollo Full Stack

**Diseño:**
- [Diseñador] - UX/UI

**Contenido Educativo:**
- [Educador] - Pedagogía y contenido

---

## 📞 Contacto

- **Email**: contacto@videojuegoeducativo.com
- **Website**: https://videojuegoeducativo.com
- **Twitter**: @VidJuegoEdu
- **GitHub**: https://github.com/tu-usuario/videojuego-educativo

---

## 🙏 Agradecimientos

- Iconos por [Flaticon](https://www.flaticon.com/)
- Ilustraciones por [unDraw](https://undraw.co/)
- Sonidos por [Freesound](https://freesound.org/)
- Fuentes por [Google Fonts](https://fonts.google.com/)
- Animaciones por [LottieFiles](https://lottiefiles.com/)

---

## ⚠️ Disclaimer

Este es un proyecto educativo diseñado para niños. Todos los contenidos han sido revisados para ser apropiados para edades 6-12 años. Si encuentra contenido inapropiado, por favor repórtelo inmediatamente.

---

**Hecho con ❤️ para hacer del aprendizaje una aventura divertida**
