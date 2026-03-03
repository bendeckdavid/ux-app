import 'dart:io';
import 'dart:async';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlarmNotificationService {
  AlarmNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const NotificationDetails _alarmNotificationDetails =
      NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_fsi_channel',
          'Alarmas',
          channelDescription: 'Canal para alarmas',
          importance: Importance.max,
          priority: Priority.high,
          category: AndroidNotificationCategory.alarm,
          fullScreenIntent: true,
          ticker: 'alarma',
        ),
      );

  final FlutterLocalNotificationsPlugin _plugin;
  void Function(NotificationResponse response)? _onAlarmTap;
  NotificationResponse? _initialLaunchResponse;

  AndroidFlutterLocalNotificationsPlugin? get _androidPlugin => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  bool get isAndroid => Platform.isAndroid;

  Future<void> initialize() async {
    tz.initializeTimeZones();
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        );

    await _plugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onAlarmTap?.call(response);
      },
    );

    final NotificationAppLaunchDetails? launchDetails = await _plugin
        .getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      _initialLaunchResponse = launchDetails?.notificationResponse;
    }

    await _requestPermissionsOnLaunch();
  }

  void setOnAlarmTap(void Function(NotificationResponse response) callback) {
    _onAlarmTap = callback;
    final NotificationResponse? initialResponse = _initialLaunchResponse;
    if (initialResponse == null) return;

    _initialLaunchResponse = null;
    callback(initialResponse);
  }

  Future<DateTime> scheduleAlarm({
    required int alarmId,
    required DateTime when,
    required String payload,
    required String title,
    required String body,
  }) async {
    final tz.TZDateTime scheduleAt = tz.TZDateTime.from(when, tz.local);

    await _plugin.cancel(id: alarmId);

    await _plugin.zonedSchedule(
      id: alarmId,
      title: title,
      body: body,
      scheduledDate: scheduleAt,
      notificationDetails: _alarmNotificationDetails,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );

    return scheduleAt.toLocal();
  }

  Future<void> cancelAlarm(int alarmId) {
    return _plugin.cancel(id: alarmId);
  }

  Future<void> _requestPermissionsOnLaunch() async {
    if (!isAndroid) return;
    await _androidPlugin?.requestNotificationsPermission();
    await _androidPlugin?.requestExactAlarmsPermission();
    await _androidPlugin?.requestFullScreenIntentPermission();
  }
}
