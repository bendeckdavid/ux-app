import '../../app/router.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CNav extends StatelessWidget {
  const CNav({super.key, required this.currentRoute, required this.onSelected});

  final String currentRoute;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: AppSize.bottomNavH,
        padding: const EdgeInsets.fromLTRB(
          AppSpace.s12,
          AppSpace.s8,
          AppSpace.s12,
          AppSpace.s8,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.border, width: AppBorderW.base),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _NavIt(
                label: 'Inicio',
                icon: Icons.home,
                active: currentRoute == AppRoutes.day,
                onTap: () => onSelected(AppRoutes.day),
              ),
            ),
            Expanded(
              child: _NavIt(
                label: 'Logros',
                icon: Icons.emoji_events,
                active: currentRoute == AppRoutes.achievements,
                onTap: () => onSelected(AppRoutes.achievements),
              ),
            ),
            Expanded(
              child: _NavIt(
                label: 'Alarmas',
                icon: Icons.alarm,
                active: currentRoute == AppRoutes.createAlarm,
                onTap: () => onSelected(AppRoutes.createAlarm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavIt extends StatelessWidget {
  const _NavIt({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.r12),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(AppSpace.s8),
            decoration: BoxDecoration(
              color: active ? AppColors.primarySoft : AppColors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.r12),
              border: Border.all(
                color: active ? AppColors.primary : AppColors.transparent,
                width: active ? AppBorderW.active : AppBorderW.base,
              ),
            ),
            child: Icon(
              icon,
              size: AppSize.iconMd,
              color: active ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpace.s4),
          Text(
            label,
            style: AppTextStyles.color(
              AppTextStyles.label12,
              active ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
