import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/alarm/alarm_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AlarmNotificationService alarmNotificationService =
      AlarmNotificationService();
  await alarmNotificationService.initialize();
  runApp(MainApp(alarmNotificationService: alarmNotificationService));
}
