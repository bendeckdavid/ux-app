import 'child_surface_card.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/app_text_styles.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.text,
    this.label = 'Nota de Mama:',
    this.backgroundColor = AppColors.surface,
    this.radius = AppRadius.r16,
    this.padding = const EdgeInsets.all(AppSpace.s16),
    this.bodyFontSize = 16,
  });

  final String label;
  final String text;
  final Color backgroundColor;
  final double radius;
  final EdgeInsetsGeometry padding;
  final double bodyFontSize;

  @override
  Widget build(BuildContext context) {
    return BoxCard(
      color: backgroundColor,
      radius: radius,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: AppTextStyles.label14),
          const SizedBox(height: AppSpace.s4),
          Text(
            text,
            style: AppTextStyles.size(
              AppTextStyles.body16Regular,
              bodyFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
