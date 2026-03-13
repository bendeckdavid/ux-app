# Alarmas UX App

Aplicacion Flutter orientada a rutinas infantiles: muestra tareas del dia, permite marcar actividades completadas, visualizar recompensas/logros y crear alarmas locales con notificaciones en Android.

## Funcionalidades

- Pantalla `Mi Dia` con lista de tareas y progreso diario.
- Flujo de detalle de actividad y marcado de tarea como completada.
- Pantalla de recompensa al completar actividades.
- Pantalla de logros con estrellas, racha y medallas.
- Creacion de alarma local (hora, icono y nombre de actividad).
- Alarma de prueba en 10 segundos desde `Mi Dia`.
- Overlay de alarma a pantalla completa con accion de confirmacion.
- Navegacion por rutas internas (`/day`, `/activity/:id`, `/reward`, `/achievements`, `/alarm/create`, `/alarm`, `/alarm/success`).
- Datos mock locales (sin backend) en `lib/data/mock/`.

## Stack tecnico

- Flutter + Dart (`sdk: ^3.11.0`).
- `flutter_local_notifications` para alarmas/notificaciones.
- `timezone` para programacion exacta de alarmas.
- `lucide_icons_flutter` para iconografia.

## Requisitos

- Flutter instalado y configurado en PATH.
- Android SDK configurado.
- JDK 17 (el proyecto Android compila con Java 17).
- Un emulador Android o dispositivo fisico con depuracion USB.

## Ejecutar en desarrollo

```bash
flutter pub get
flutter run
```

Opcional:

```bash
flutter analyze
flutter test
```

## Construir APK

### APK debug

```bash
flutter build apk --debug
```

Salida esperada:

- `build/app/outputs/flutter-apk/app-debug.apk`

### APK release

```bash
flutter build apk --release
```

Salida esperada:

- `build/app/outputs/flutter-apk/app-release.apk`

## Permisos Android usados

Declarados en `android/app/src/main/AndroidManifest.xml`:

- `POST_NOTIFICATIONS`
- `RECEIVE_BOOT_COMPLETED`
- `SCHEDULE_EXACT_ALARM`
- `USE_FULL_SCREEN_INTENT`

## Estructura principal

- `lib/main.dart`: punto de entrada.
- `lib/app/`: app shell, tema y router.
- `lib/presentation/`: pantallas y widgets de UI.
- `lib/src/alarm/alarm_notification_service.dart`: logica de notificaciones y alarmas.
- `lib/data/mock/`: repositorio y data de ejemplo.
