import 'child_success_badge.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/app_text_styles.dart';

class OkHead extends StatelessWidget {
  const OkHead({
    super.key,
    required this.title,
    required this.subtitle,
    this.badgeSize = AppSize.heroBadge,
    this.badgeIconSize = AppSize.heroBadgeIcon,
    this.titleSize = 28,
    this.subtitleSize = 16,
  });

  final String title;
  final String subtitle;
  final double badgeSize;
  final double badgeIconSize;
  final double titleSize;
  final double subtitleSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OkBadge(size: badgeSize, iconSize: badgeIconSize),
        const SizedBox(height: AppSpace.s12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.size(AppTextStyles.title28, titleSize),
        ),
        const SizedBox(height: AppSpace.s4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.size(
            AppTextStyles.color(AppTextStyles.body16, AppColors.textSecondary),
            subtitleSize,
          ),
        ),
      ],
    );
  }
}
