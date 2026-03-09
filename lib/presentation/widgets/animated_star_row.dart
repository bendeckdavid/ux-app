import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';

class StarRow extends StatelessWidget {
  const StarRow({
    super.key,
    required this.total,
    required this.filled,
    this.size = AppSize.star,
    this.baseDurationMs = AppMotion.starBaseMs,
    this.staggerMs = AppMotion.starStaggerMs,
    this.filledColor = AppColors.reward,
    this.unfilledColor = AppColors.textMuted,
  });

  final int total;
  final int filled;
  final double size;
  final int baseDurationMs;
  final int staggerMs;
  final Color filledColor;
  final Color unfilledColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(total, (int index) {
        final bool isFilled = index < filled;
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(
            milliseconds: baseDurationMs + (index * staggerMs),
          ),
          curve: AppMotion.easeOutBack,
          builder: (BuildContext context, double value, Widget? child) {
            return Transform.scale(scale: value, child: child);
          },
          child: Icon(
            isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
            color: isFilled ? filledColor : unfilledColor,
            size: size,
          ),
        );
      }),
    );
  }
}
