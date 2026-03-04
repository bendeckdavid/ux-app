import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class Inp extends StatelessWidget {
  const Inp({
    super.key,
    this.label,
    required this.controller,
    this.hintText,
    this.textAlign = TextAlign.start,
    this.onChanged,
  });

  final String? label;
  final TextEditingController controller;
  final String? hintText;
  final TextAlign textAlign;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null) ...<Widget>[
          Text(label!, style: AppTextStyles.label14),
          const SizedBox(height: AppSpace.s8),
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          textAlign: textAlign,
          style: AppTextStyles.body16,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.size(
              AppTextStyles.body16,
              15,
            ).copyWith(color: AppColors.textMuted),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpace.s16,
              vertical: AppSpace.s16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r12),
              borderSide: const BorderSide(
                color: AppColors.border,
                width: AppBorderW.base,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: AppBorderW.active,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r12),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: AppBorderW.base,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
