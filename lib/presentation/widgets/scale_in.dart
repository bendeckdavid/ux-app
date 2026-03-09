import 'package:flutter/material.dart';
import '../../../core/theme/app_tokens.dart';

class ScIn extends StatelessWidget {
  const ScIn({
    super.key,
    required this.child,
    this.begin = 0,
    this.duration = AppMotion.scaleSpring,
    this.curve = AppMotion.elasticOut,
  });

  final Widget child;
  final double begin;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: begin, end: 1),
      duration: duration,
      curve: curve,
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.scale(scale: value, child: child);
      },
      child: child,
    );
  }
}

class FdScIn extends StatelessWidget {
  const FdScIn({
    super.key,
    required this.child,
    this.begin = AppMotion.scaleBegin,
    this.duration = AppMotion.pageIn,
    this.curve = AppMotion.easeOut,
  });

  final Widget child;
  final double begin;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: begin, end: 1),
      duration: duration,
      curve: curve,
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(scale: value, child: child),
        );
      },
      child: child,
    );
  }
}
