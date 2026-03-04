import 'tap_scale.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_text_styles.dart';
import 'package:flutter/material.dart';

enum BtnVar { primary, outline, secondary, ghost, link, cta, destructive }

enum BtnSz { defaultSize, sm, lg, icon, kid }

class Btn extends StatelessWidget {
  const Btn({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = BtnVar.primary,
    this.size,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final BtnVar variant;
  final BtnSz? size;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    final Color bgColor;
    final Color borderColor;
    final Color textColor;

    switch (variant) {
      case BtnVar.primary:
        bgColor = AppColors.primary;
        borderColor = AppColors.primary;
        textColor = AppColors.surface;
        break;
      case BtnVar.cta:
        bgColor = AppColors.primaryHover;
        borderColor = AppColors.primaryHover;
        textColor = AppColors.surface;
        break;
      case BtnVar.outline:
        bgColor = AppColors.surface;
        borderColor = AppColors.primary;
        textColor = AppColors.primary;
        break;
      case BtnVar.secondary:
        bgColor = AppColors.surfaceMuted;
        borderColor = AppColors.border;
        textColor = AppColors.textPrimary;
        break;
      case BtnVar.ghost:
        bgColor = AppColors.transparent;
        borderColor = AppColors.transparent;
        textColor = AppColors.textSecondary;
        break;
      case BtnVar.link:
        bgColor = AppColors.transparent;
        borderColor = AppColors.transparent;
        textColor = AppColors.primary;
        break;
      case BtnVar.destructive:
        bgColor = AppColors.error;
        borderColor = AppColors.error;
        textColor = AppColors.surface;
        break;
    }

    final double height = _resolveHeight();
    final bool isPrimaryLike =
        variant == BtnVar.primary || variant == BtnVar.cta;

    return Opacity(
      opacity: isEnabled ? 1 : AppMotion.disabledOpacity,
      child: TScale(
        onTap: onPressed,
        child: Container(
          width: size == BtnSz.icon ? height : null,
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppRadius.r12),
            border: Border.all(
              color: borderColor,
              width: isPrimaryLike ? AppBorderW.active : AppBorderW.base,
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, size: AppSize.iconLg, color: textColor),
                const SizedBox(width: AppSpace.s8),
              ],
              Text(
                label,
                style: AppTextStyles.color(
                  variant == BtnVar.link
                      ? AppTextStyles.link
                      : AppTextStyles.body16,
                  textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _resolveHeight() {
    switch (size) {
      case BtnSz.defaultSize:
        return AppSize.buttonDefaultH;
      case BtnSz.sm:
        return AppSize.buttonSmH;
      case BtnSz.lg:
        return AppSize.buttonLgH;
      case BtnSz.icon:
        return AppSize.buttonIconH;
      case BtnSz.kid:
        return AppSize.buttonKidH;
      case null:
        return variant == BtnVar.primary ||
                variant == BtnVar.cta ||
                variant == BtnVar.destructive
            ? AppSize.buttonKidH
            : AppSize.buttonDefaultH;
    }
  }
}
