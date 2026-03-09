import '../../../app/router.dart';
import 'package:flutter/material.dart';

void popOrGoDay(BuildContext context) {
  final NavigatorState navigator = Navigator.of(context);
  if (navigator.canPop()) {
    navigator.pop();
    return;
  }
  goDayRoot(context);
}

void goDayRoot(BuildContext context) {
  Navigator.of(
    context,
  ).pushNamedAndRemoveUntil(AppRoutes.day, (Route<dynamic> route) => false);
}
