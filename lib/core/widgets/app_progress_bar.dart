import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import 'package:flutter/material.dart';

class PBar extends StatelessWidget {
  const PBar({super.key, required this.value, this.color = AppColors.success});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double safeValue = value.clamp(0, 1);

    return Container(
      height: AppSize.progressBarH,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.r20),
        border: Border.all(color: color, width: AppBorderW.base),
      ),
      clipBehavior: Clip.antiAlias,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: safeValue,
          child: Container(color: color),
        ),
      ),
    );
  }
}
