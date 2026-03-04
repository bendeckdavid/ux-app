import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/child_bottom_nav.dart';

class CScaf extends StatelessWidget {
  const CScaf({super.key, required this.currentRoute, required this.child});

  final String currentRoute;
  final Widget child;

  void _go(BuildContext context, String route) {
    if (route == currentRoute) return;
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(route, (Route<dynamic> r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(child: child),
      bottomNavigationBar: CNav(
        currentRoute: currentRoute,
        onSelected: (String route) => _go(context, route),
      ),
    );
  }
}
