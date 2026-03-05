import 'dart:io';
import 'dart:async';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlarmPermissionStatus {
  const AlarmPermissionStatus({
    required this.notificationsGranted,
    required this.exactAlarmGranted,
    required this.fullScreenIntentGranted,
  });

  final bool notificationsGranted;
  final bool exactAlarmGranted;
  final bool fullScreenIntentGranted;

  bool get canScheduleAlarm => notificationsGranted && exactAlarmGranted;
  bool get canShowFullScreenIntent =>
      canScheduleAlarm && fullScreenIntentGranted;
}

class AlarmNotificationService {
  AlarmNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static final AlarmNotificationService instance = AlarmNotificationService();
  static const String _alarmChannelId = 'alarm_fsi_channel_v2';

  static const NotificationDetails _alarmNotificationDetails =
      NotificationDetails(
        android: AndroidNotificationDetails(
          _alarmChannelId,
          'Alarmas',
          channelDescription: 'Canal para alarmas',
          importance: Importance.max,
          priority: Priority.max,
          category: AndroidNotificationCategory.alarm,
          fullScreenIntent: true,
          audioAttributesUsage: AudioAttributesUsage.alarm,
          ticker: 'alarma',
        ),
      );

  final FlutterLocalNotificationsPlugin _plugin;
  Future<void>? _initializeFuture;
  void Function(String? payload)? _onAlarmTap;
  NotificationResponse? _initialLaunchResponse;

  AndroidFlutterLocalNotificationsPlugin? get _androidPlugin => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  bool get isAndroid => Platform.isAndroid;

  Future<void> ensureInitialized() {
    return _initializeFuture ??= _initializeInternal();
  }

  Future<void> initialize() {
    return ensureInitialized();
  }

  Future<void> _initializeInternal() async {
    tz.initializeTimeZones();
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        );

    await _plugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onAlarmTap?.call(response.payload);
      },
    );

    await _setupAlarmChannel();

    final NotificationAppLaunchDetails? launchDetails = await _plugin
        .getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      _initialLaunchResponse = launchDetails?.notificationResponse;
    }

    final NotificationResponse? initialResponse = _initialLaunchResponse;
    if (initialResponse != null && _onAlarmTap != null) {
      _initialLaunchResponse = null;
      _onAlarmTap!.call(initialResponse.payload);
    }

    await _requestPermissionsOnLaunch();
  }

  void setOnAlarmTap(void Function(String? payload) callback) {
    _onAlarmTap = callback;
    final NotificationResponse? initialResponse = _initialLaunchResponse;
    if (initialResponse == null) return;

    _initialLaunchResponse = null;
    callback(initialResponse.payload);
  }

  Future<DateTime> scheduleAlarm({
    required int alarmId,
    required DateTime when,
    required String payload,
    required String title,
    required String body,
  }) async {
    await ensureInitialized();
    final tz.TZDateTime scheduleAt = tz.TZDateTime.from(when, tz.local);

    await _plugin.cancel(id: alarmId);

    await _plugin.zonedSchedule(
      id: alarmId,
      title: title,
      body: body,
      scheduledDate: scheduleAt,
      notificationDetails: _alarmNotificationDetails,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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

  Future<AlarmPermissionStatus> ensureAlarmPermissions() async {
    await ensureInitialized();
    if (!isAndroid) {
      return const AlarmPermissionStatus(
        notificationsGranted: true,
        exactAlarmGranted: true,
        fullScreenIntentGranted: true,
      );
    }

    final bool notificationsGranted =
        await _androidPlugin?.requestNotificationsPermission() ?? true;
    final bool? exactGranted = await _androidPlugin
        ?.requestExactAlarmsPermission();
    final bool canExact =
        await _androidPlugin?.canScheduleExactNotifications() ?? true;
    final bool fullScreenGranted =
        await _androidPlugin?.requestFullScreenIntentPermission() ?? true;

    return AlarmPermissionStatus(
      notificationsGranted: notificationsGranted,
      exactAlarmGranted: (exactGranted ?? true) && canExact,
      fullScreenIntentGranted: fullScreenGranted,
    );
  }

  Future<void> _setupAlarmChannel() async {
    if (!isAndroid) return;

    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      _alarmChannelId,
      'Alarmas',
      description: 'Canal para alarmas',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      audioAttributesUsage: AudioAttributesUsage.alarm,
    );

    await _androidPlugin?.createNotificationChannel(channel);
  }
}
