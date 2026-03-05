import '../core/theme/app_tokens.dart';
import 'package:flutter/material.dart';
import '../presentation/day/my_day_page.dart';
import '../presentation/reward/reward_page.dart';
import '../presentation/alarm/create_alarm_page.dart';
import '../presentation/alarm/alarm_overlay_page.dart';
import '../presentation/alarm/alarm_success_page.dart';
import '../presentation/achievements/achievements_page.dart';
import '../presentation/activity_detail/activity_detail_page.dart';

class AppRoutes {
  static const String day = '/day';
  static const String activityBase = '/activity';
  static const String reward = '/reward';
  static const String achievements = '/achievements';
  static const String createAlarm = '/alarm/create';
  static const String alarm = '/alarm';
  static const String alarmSuccess = '/alarm/success';

  static String activity(String id) => '$activityBase/$id';
}

Route<dynamic> onGenerateAppRoute(RouteSettings settings) {
  final String name = settings.name ?? AppRoutes.day;

  if (name == AppRoutes.day) return _page(const DayPg(), settings);

  if (name == AppRoutes.reward) return _page(const RwdPg(), settings);

  if (name == AppRoutes.achievements) return _page(const AchPg(), settings);

  if (name == AppRoutes.createAlarm) return _page(const AlmNewPg(), settings);

  if (name == AppRoutes.alarm) return _overlayPage(const AlmOvPg(), settings);

  if (name == AppRoutes.alarmSuccess) return _page(const AlmOkPg(), settings);

  final Uri uri = Uri.parse(name);
  if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'activity') {
    final String id = uri.pathSegments[1];
    return _page(ActPg(taskId: id), settings);
  }

  return _page(const DayPg(), settings);
}

MaterialPageRoute<dynamic> _page(Widget child, RouteSettings settings) =>
    MaterialPageRoute<dynamic>(settings: settings, builder: (_) => child);

PageRouteBuilder<dynamic> _overlayPage(Widget child, RouteSettings settings) {
  return PageRouteBuilder<dynamic>(
    settings: settings,
    opaque: false,
    transitionDuration: AppMotion.overlay,
    reverseTransitionDuration: AppMotion.overlay,
    pageBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) => child,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget pageChild,
        ) => FadeTransition(opacity: animation, child: pageChild),
  );
}
