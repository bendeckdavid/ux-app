import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/tap_scale.dart';

class IBtn extends StatelessWidget {
  const IBtn({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = AppSize.buttonIconH,
    this.radius = AppRadius.r12,
    this.circular = false,
    this.backgroundColor = AppColors.surface,
    this.borderColor = AppColors.border,
    this.iconColor = AppColors.textPrimary,
    this.borderWidth = AppBorderW.base,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double radius;
  final bool circular;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return TScale(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: circular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: circular ? null : BorderRadius.circular(radius),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
