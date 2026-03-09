import 'child_surface_card.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_progress_bar.dart';

class ProgCard extends StatelessWidget {
  const ProgCard({
    super.key,
    required this.title,
    required this.progress,
    required this.counterLabel,
    this.footnote,
    this.progressColor = AppColors.success,
  });

  final String title;
  final double progress;
  final String counterLabel;
  final String? footnote;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return BoxCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: AppTextStyles.label13,
              ),
              Text(
                counterLabel,
                style: AppTextStyles.color(
                  AppTextStyles.size(AppTextStyles.body16, 16),
                  progressColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.s8),
          PBar(value: progress, color: progressColor),
          if (footnote != null) ...<Widget>[
            const SizedBox(height: AppSpace.s8),
            Text(
              footnote!.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyles.color(
                AppTextStyles.label13,
                progressColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
