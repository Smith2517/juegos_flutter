# 🚀 Cómo Ejecutar el Proyecto

## ✅ Problema Resuelto

El error "Unable to launch Flutter project in a Dart-only workspace" ha sido **solucionado**.

**Solución aplicada**: Se inicializó correctamente el proyecto Flutter con `flutter create`.

---

## 🎯 Ejecutar Ahora (3 métodos)

### Método 1: Desde VS Code (Recomendado)

1. **Abre VS Code** en la carpeta del proyecto
2. **Presiona F5** o click en "Run > Start Debugging"
3. **Selecciona**: "Chrome" cuando te pregunte el dispositivo
4. ¡La app se abrirá en el navegador!

**Atajo de teclado**: `F5`

---

### Método 2: Desde la Terminal

```bash
# Navega a la carpeta del proyecto
cd "c:\Users\USUARIO\Documents\CLASES 2025-2\INTERACCION HUMANO COMPUTADOR\PROYECT"

# Ejecuta en Chrome
flutter run -d chrome
```

**Tiempo de inicio**: 30-60 segundos (primera vez)

---

### Método 3: Desde VS Code Terminal Integrada

1. En VS Code, presiona **Ctrl + `** (abre terminal)
2. Ejecuta:
   ```bash
   flutter run -d chrome
   ```

---

## ⚠️ Error Esperado al Ejecutar

Cuando ejecutes el proyecto, verás este error en la consola:

```
[ERROR:flutter/runtime/dart_vm_initializer.cc(41)]
Unhandled Exception: [core/not-initialized]
Firebase has not been correctly initialized.
```

**Esto es COMPLETAMENTE NORMAL** ✅

### ¿Por qué ocurre?

Porque aún **no has configurado las credenciales de Firebase** en el archivo `firebase_service.dart`.

### ¿La app funcionará?

- ❌ **Login/Auth**: No funcionará (necesita Firebase)
- ✅ **UI/Navegación**: Funcionará perfectamente
- ✅ **Tema/Diseño**: Se verá bien
- ✅ **Hot Reload**: Funcionará

**La app se abrirá** y verás la pantalla de splash, pero no podrás avanzar hasta configurar Firebase.

---

## 🔥 Configurar Firebase (Obligatorio para funcionalidad completa)

### Paso 1: Crear Proyecto Firebase

1. Ve a: https://console.firebase.google.com/
2. Click "Agregar proyecto"
3. Nombre: `videojuego-educativo`
4. Seguir asistente (habilitar Analytics opcional)

### Paso 2: Habilitar Servicios

En Firebase Console:

**Authentication**:
- Click "Authentication" → "Comenzar"
- Pestaña "Sign-in method"
- **Habilitar**: "Anónimo" ✅

**Firestore Database**:
- Click "Firestore Database" → "Crear base de datos"
- Modo: **Producción**
- Ubicación: Elige más cercana

**Storage**:
- Click "Storage" → "Comenzar"
- Modo: **Producción**

### Paso 3: Obtener Configuración Web

1. Firebase Console → ⚙️ "Configuración del proyecto"
2. Scroll down → "Tus apps"
3. Click ícono web `</>`
4. Nombre de app: `videojuego-educativo-web`
5. **COPIAR** el objeto `firebaseConfig`

### Paso 4: Actualizar Código

**Abre**: `lib/data/datasources/remote/firebase_service.dart`

**Busca línea ~30** y reemplaza:

```dart
apiKey: "YOUR_API_KEY",
authDomain: "YOUR_AUTH_DOMAIN",
projectId: "YOUR_PROJECT_ID",
storageBucket: "YOUR_STORAGE_BUCKET",
messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
appId: "YOUR_APP_ID",
```

**Con tus valores reales** del paso 3.

### Paso 5: Reiniciar App

Después de actualizar las credenciales:

1. Detén la app (en terminal presiona `q`)
2. Ejecuta de nuevo: `flutter run -d chrome`
3. ¡Ahora debería funcionar completamente! 🎉

---

## 🔧 Solución de Problemas

### Error: "No devices found"

**Solución**:
```bash
# Ver dispositivos disponibles
flutter devices

# Si Chrome no aparece, cierra VS Code y ábrelo de nuevo
```

### Error: "pub get failed"

**Solución**:
```bash
flutter clean
flutter pub get
```

### Error: "Command not found: flutter"

**Solución**:
1. Cierra VS Code
2. Abre PowerShell como administrador
3. Ejecuta: `flutter doctor`
4. Reinicia VS Code

### La app no carga / Pantalla blanca

**Solución**:
1. Abre DevTools (F12 en Chrome)
2. Mira errores en Console
3. Si dice "Firebase not initialized" → Configura Firebase (Paso 4 arriba)

### Hot Reload no funciona

**Solución**:
- En la terminal donde corre la app, presiona:
  - `r` → Hot reload
  - `R` → Hot restart
  - `q` → Quit (salir)

---

## 📋 Checklist de Ejecución

- [x] Proyecto Flutter inicializado ✅
- [x] Dependencias instaladas ✅
- [x] Chrome disponible ✅
- [x] VS Code configurado ✅
- [ ] Firebase configurado ⬜ (opcional para testing básico)
- [ ] App ejecutándose ⬜

---

## 🎮 Comandos Útiles

```bash
# Ver dispositivos disponibles
flutter devices

# Ejecutar en Chrome
flutter run -d chrome

# Ejecutar con logs detallados
flutter run -d chrome -v

# Build para producción
flutter build web --release

# Limpiar proyecto
flutter clean

# Reinstalar dependencias
flutter pub get

# Analizar código
flutter analyze

# Ver versión de Flutter
flutter --version

# Ver estado de Flutter
flutter doctor
```

---

## 🚀 Flujo de Desarrollo Recomendado

### 1. Primera Ejecución (Hoy)

```bash
# Terminal 1: Ejecutar app
flutter run -d chrome

# Verás: Splash screen + error de Firebase (normal)
```

### 2. Configurar Firebase (15 minutos)

- Seguir pasos arriba
- Actualizar `firebase_service.dart`
- Reiniciar app

### 3. Desarrollo Diario

```bash
# 1. Abrir VS Code en carpeta del proyecto
# 2. Presionar F5
# 3. Desarrollar con Hot Reload activo (presionar 'r' al guardar cambios)
```

---

## 📊 Estado del Proyecto

| Componente | Estado |
|------------|--------|
| ✅ Proyecto inicializado | Completo |
| ✅ Dependencias instaladas | Completo |
| ✅ Código libre de errores | Completo |
| ✅ Chrome disponible | Completo |
| ⬜ Firebase configurado | Pendiente |
| ⬜ App funcionando 100% | Pendiente |

---

## 🎯 Próximos Pasos

### Ahora (5 minutos)

1. **Ejecuta**: `flutter run -d chrome`
2. **Verifica**: Que la app se abre (aunque con error Firebase)
3. **Celebra**: ¡Tu proyecto Flutter está vivo! 🎊

### Después (15 minutos)

1. **Lee**: Pasos de Firebase arriba
2. **Configura**: Credenciales en `firebase_service.dart`
3. **Ejecuta**: De nuevo y disfruta app funcional

### Esta semana

1. **Implementa**: Login completo (código en `EJEMPLOS_CODIGO.md`)
2. **Crea**: Home screen con categorías
3. **Diseña**: Primer minijuego

---

## 💡 Tips de Desarrollo

### Hot Reload

Cuando la app esté corriendo:
- **Modifica** cualquier archivo `.dart`
- **Guarda** (Ctrl+S)
- **Presiona** `r` en la terminal
- **Ve** los cambios instantáneamente ⚡

### DevTools

Abre Chrome DevTools (F12) para:
- Ver logs de la app
- Inspeccionar red (requests Firebase)
- Debug JavaScript/CSS
- Performance monitoring

### VS Code Extensions Recomendadas

- **Flutter** (por Dart Code)
- **Dart** (por Dart Code)
- **Error Lens** (para ver errores inline)
- **Better Comments** (para comentarios coloridos)

---

## ✨ ¡Listo para Ejecutar!

Tu proyecto está **perfectamente configurado** y listo para correr.

**Comando para ejecutar AHORA**:

```bash
flutter run -d chrome
```

**Tiempo estimado hasta ver la app**: 30-60 segundos

**Resultado esperado**: Pantalla de splash + error Firebase (configúralo después)

---

## 📞 Si Necesitas Ayuda

1. **Revisa**: DevTools Console (F12) para errores específicos
2. **Ejecuta**: `flutter doctor` para verificar instalación
3. **Lee**: `PROYECTO_LISTO.md` para configuración Firebase completa

---

**¡Éxito ejecutando tu videojuego educativo!** 🎮🚀

El momento que esperabas ha llegado - presiona F5 y ve tu creación cobrar vida. 🌟
