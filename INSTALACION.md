# 🚀 Guía de Instalación - Videojuego Educativo

## ⚠️ IMPORTANTE: Sobre los Errores Actuales

**TODOS los errores que ves en VS Code/IDE son NORMALES.**

Se resolverán automáticamente cuando ejecutes los comandos de instalación.

---

## 📋 Requisitos Previos

1. **Flutter SDK** instalado
   - Descargar de: https://flutter.dev/docs/get-started/install
   - Verificar instalación: `flutter --version`

2. **Node.js** (para Firebase CLI)
   - Descargar de: https://nodejs.org/
   - Verificar instalación: `node --version`

3. **Git** (opcional, recomendado)
   - Descargar de: https://git-scm.com/

4. **Editor de código**
   - VS Code (recomendado): https://code.visualstudio.com/
   - Android Studio: https://developer.android.com/studio

---

## 🔧 Instalación Paso a Paso

### Paso 1: Verificar Flutter

Abre una terminal en la carpeta del proyecto y ejecuta:

```bash
flutter doctor
```

Debe mostrar que Flutter está instalado correctamente. Si hay problemas, sigue las instrucciones que muestra.

### Paso 2: Instalar Dependencias de Flutter

```bash
flutter pub get
```

**Este comando descargará e instalará todos los paquetes necesarios.**

Después de este comando:
- ✅ Todos los errores de "undefined" desaparecerán
- ✅ Los imports se resolverán
- ✅ El IDE dejará de mostrar errores

**Tiempo estimado: 2-5 minutos (dependiendo de conexión)**

### Paso 3: Verificar que Todo Funciona

```bash
flutter analyze
```

Deberías ver: "No issues found!"

Si hay algunos warnings menores, está bien. Los errores críticos deben estar resueltos.

### Paso 4: Configurar Firebase

#### 4.1 Instalar Firebase CLI

```bash
npm install -g firebase-tools
```

Verificar instalación:
```bash
firebase --version
```

#### 4.2 Login en Firebase

```bash
firebase login
```

Esto abrirá tu navegador para autenticarte con Google.

#### 4.3 Crear Proyecto en Firebase Console

1. Ir a: https://console.firebase.google.com/
2. Click en "Agregar proyecto"
3. Nombre del proyecto: "videojuego-educativo" (o el que prefieras)
4. Seguir los pasos (habilitar Google Analytics opcional)

#### 4.4 Habilitar Servicios de Firebase

En Firebase Console, habilita:

1. **Authentication**:
   - Click en "Authentication" → "Comenzar"
   - Habilitar "Anónimo" (Sign-in method)
   - Habilitar "Correo electrónico/contraseña" (opcional, para padres)

2. **Firestore Database**:
   - Click en "Firestore Database" → "Crear base de datos"
   - Iniciar en modo de **producción**
   - Seleccionar ubicación (preferiblemente cercana a tu región)

3. **Storage**:
   - Click en "Storage" → "Comenzar"
   - Iniciar en modo de producción

4. **Analytics** (Opcional):
   - Ya habilitado si lo seleccionaste al crear proyecto

#### 4.5 Obtener Configuración de Firebase

1. En Firebase Console, ve a "Project Settings" (ícono de engranaje)
2. En "Your apps", selecciona el ícono web (</>)
3. Registra tu app con un nombre (ej: "videojuego-educativo-web")
4. Copia la configuración de Firebase que se muestra

#### 4.6 Actualizar Código con Configuración

Abre el archivo: `lib/data/datasources/remote/firebase_service.dart`

Reemplaza estas líneas (alrededor de línea 30):
```dart
apiKey: "YOUR_API_KEY",
authDomain: "YOUR_AUTH_DOMAIN",
projectId: "YOUR_PROJECT_ID",
storageBucket: "YOUR_STORAGE_BUCKET",
messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
appId: "YOUR_APP_ID",
```

Con tus valores reales de Firebase Console.

#### 4.7 Inicializar Firebase en el Proyecto

```bash
firebase init
```

Seleccionar con ESPACIO:
- ☑ Firestore
- ☑ Storage
- ☑ Hosting

Configuración recomendada:
- Firestore rules: `firestore.rules` (presionar Enter)
- Firestore indexes: `firestore.indexes.json` (presionar Enter)
- Storage rules: `storage.rules` (presionar Enter)
- Public directory: `build/web` (presionar Enter)
- Single-page app: **Yes**
- Set up automatic builds: **No**

#### 4.8 Subir Reglas de Seguridad

```bash
firebase deploy --only firestore:rules,storage:rules
```

---

## ▶️ Ejecutar la Aplicación

### En el Navegador (Chrome)

```bash
flutter run -d chrome
```

### Ver Dispositivos Disponibles

```bash
flutter devices
```

### Modo Debug vs Release

```bash
# Modo debug (desarrollo)
flutter run -d chrome

# Modo release (optimizado)
flutter run -d chrome --release
```

---

## 🧪 Testing

### Ejecutar Tests

```bash
# Todos los tests
flutter test

# Con cobertura
flutter test --coverage
```

### Analizar Código

```bash
flutter analyze
```

### Formatear Código

```bash
dart format .
```

---

## 📦 Build para Producción

### Build Web

```bash
flutter build web --release
```

Los archivos compilados estarán en: `build/web/`

### Deploy a Firebase Hosting

```bash
firebase deploy --only hosting
```

Tu app estará disponible en: `https://TU-PROYECTO.web.app`

---

## 🐛 Solución de Problemas Comunes

### Error: "Flutter SDK not found"

**Solución**:
1. Verifica que Flutter esté instalado: `flutter --version`
2. Agrega Flutter al PATH de tu sistema
3. Reinicia el IDE

### Error: "pub get failed"

**Solución**:
```bash
flutter clean
flutter pub get
```

### Error: "Firebase not initialized"

**Solución**:
1. Verifica que hayas copiado la configuración correcta en `firebase_service.dart`
2. Asegúrate de que Firebase está inicializado en `main.dart`

### Errores de "undefined" persisten

**Solución**:
1. Ejecutar: `flutter pub get`
2. Reiniciar el IDE (VS Code: Ctrl+Shift+P → "Reload Window")
3. Si persiste: `flutter clean` y luego `flutter pub get`

### Error: "MissingPluginException"

**Solución** (solo si usas mobile):
```bash
flutter clean
flutter pub get
# En Android: flutter run
# En iOS: cd ios && pod install && cd ..
```

---

## 📝 Verificación Final

Después de la instalación, verifica:

✅ `flutter pub get` se ejecutó sin errores
✅ `flutter analyze` no muestra errores críticos
✅ `flutter run -d chrome` inicia la aplicación
✅ No hay errores rojos en el IDE
✅ Firebase está configurado correctamente

---

## 📚 Próximos Pasos

Una vez instalado todo:

1. **Lee**: `ESTADO_ACTUAL.md` - Estado del proyecto
2. **Implementa**: Código faltante usando `EJEMPLOS_CODIGO.md`
3. **Diseña**: Primer minijuego según `MECANICAS_JUEGO.md`
4. **Agrega**: Assets (imágenes, sonidos) según `assets/README.md`

---

## 🆘 Obtener Ayuda

Si tienes problemas:

1. **Documentación Flutter**: https://flutter.dev/docs
2. **Firebase Docs**: https://firebase.google.com/docs
3. **Stack Overflow**: https://stackoverflow.com/questions/tagged/flutter
4. **Discord Flutter**: https://discord.gg/flutter

---

## ✅ Checklist de Instalación

- [ ] Flutter instalado y funcionando
- [ ] `flutter pub get` ejecutado exitosamente
- [ ] Firebase CLI instalado
- [ ] Proyecto Firebase creado
- [ ] Services habilitados (Auth, Firestore, Storage)
- [ ] Configuración copiada a `firebase_service.dart`
- [ ] `firebase init` ejecutado
- [ ] Reglas de seguridad subidas
- [ ] `flutter run -d chrome` funciona
- [ ] No hay errores en el IDE

**¡Cuando todo esté ✅, estarás listo para desarrollar!**

---

## ⏱️ Tiempo Estimado de Instalación

- Instalación de Flutter: 10-20 min (si no lo tienes)
- `flutter pub get`: 2-5 min
- Configuración Firebase: 10-15 min
- **Total: 20-40 minutos**

**¡Éxito con la instalación!** 🚀
