import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'alarm/alarm_ring_screen.dart';
import 'alarm/alarm_notification_service.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.alarmNotificationService});

  final AlarmNotificationService alarmNotificationService;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    widget.alarmNotificationService.setOnAlarmTap(_openAlarmScreen);
  }

  void _openAlarmScreen(NotificationResponse? response) {
    final int? alarmId = response?.id;
    if (alarmId == null) {
      return;
    }

    final NavigatorState? navigator = _navigatorKey.currentState;
    if (navigator == null) {
      return;
    }

    navigator.push(
      MaterialPageRoute<void>(
        builder: (_) => AlarmRingScreen(
          alarmNotificationService: widget.alarmNotificationService,
          alarmId: alarmId,
          payload: response?.payload,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      home: const _IntegrationPlaceholderScreen(),
    );
  }
}

class _IntegrationPlaceholderScreen extends StatelessWidget {
  const _IntegrationPlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Aplicacion Alarmas',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
