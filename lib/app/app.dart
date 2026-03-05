import 'dart:async';
import 'router.dart';
import '../core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../core/theme/app_tokens.dart';
import '../src/alarm/alarm_notification_service.dart';

class AlApp extends StatefulWidget {
  const AlApp({super.key});

  @override
  State<AlApp> createState() => _AlarmasAppState();
}

class _AlarmasAppState extends State<AlApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final AlarmNotificationService _alarmService =
      AlarmNotificationService.instance;

  String? _pendingRoute;

  @override
  void initState() {
    super.initState();
    _alarmService.setOnAlarmTap(_handleAlarmTap);
    unawaited(_alarmService.ensureInitialized());
  }

  void _handleAlarmTap(String? payload) {
    final String route = payload != null && payload.startsWith('/')
        ? payload
        : AppRoutes.alarm;
    _openRoute(route);
  }

  void _openRoute(String route) {
    final NavigatorState? navigator = _navigatorKey.currentState;
    if (navigator == null) {
      _pendingRoute = route;
      WidgetsBinding.instance.addPostFrameCallback((_) => _flushPendingRoute());
      return;
    }
    navigator.pushNamed(route);
  }

  void _flushPendingRoute() {
    final String? route = _pendingRoute;
    if (route == null) return;
    _pendingRoute = null;
    _openRoute(route);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: buildAppTheme(),
      themeAnimationDuration: AppMotion.switcher,
      initialRoute: AppRoutes.day,
      onGenerateRoute: onGenerateAppRoute,
    );
  }
}
