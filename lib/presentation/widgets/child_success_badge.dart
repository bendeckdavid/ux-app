import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';

class OkBadge extends StatelessWidget {
  const OkBadge({
    super.key,
    this.size = AppSize.heroBadge,
    this.iconSize = AppSize.heroBadgeIcon,
    this.borderWidth = AppBorderW.emphasis,
  });

  final double size;
  final double iconSize;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.successSoft,
        border: Border.all(color: AppColors.success, width: borderWidth),
      ),
      child: Icon(Icons.check, color: AppColors.success, size: iconSize),
    );
  }
}
