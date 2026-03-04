import 'package:flutter/material.dart';
import '../../../core/theme/app_tokens.dart';

class PgIn extends StatelessWidget {
  const PgIn({
    super.key,
    required this.child,
    this.duration = AppMotion.pageIn,
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: duration,
      curve: AppMotion.easeOut,
      builder: (BuildContext context, double value, Widget? _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * AppOffset.pageEntryY),
            child: child,
          ),
        );
      },
    );
  }
}
