import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';

class BoxCard extends StatelessWidget {
  const BoxCard({
    super.key,
    required this.child,
    this.width,
    this.padding = const EdgeInsets.all(AppSpace.s16),
    this.radius = AppRadius.r16,
    this.color = AppColors.surface,
    this.borderColor = AppColors.border,
    this.borderWidth = AppBorderW.base,
    this.boxShadow,
  });

  final Widget child;
  final double? width;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
