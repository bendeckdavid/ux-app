import '../../../app/router.dart';
import '../widgets/scale_in.dart';
import 'package:flutter/material.dart';
import '../widgets/child_scaffold.dart';
import '../widgets/child_navigation.dart';
import '../widgets/animated_star_row.dart';
import '../widgets/child_surface_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_progress_bar.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../data/mock/child_mock_repository.dart';

class RwdPg extends StatelessWidget {
  const RwdPg({super.key});

  @override
  Widget build(BuildContext context) {
    final ChildMockRepository repo = ChildMockRepository.instance;

    return CScaf(
      currentRoute: AppRoutes.day,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpace.s24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ScIn(
                begin: 0,
                duration: AppMotion.scaleSpring,
                curve: AppMotion.elasticOut,
                child: Icon(
                  Icons.star_rounded,
                  size: AppSize.heroStar,
                  color: AppColors.reward,
                ),
              ),
              const SizedBox(height: AppSpace.s8),
              Text(
                'Buen Trabajo',
                textAlign: TextAlign.center,
                style: AppTextStyles.title28,
              ),
              const SizedBox(height: AppSpace.s4),
              Text(
                '+1 estrella ganada',
                textAlign: TextAlign.center,
                style: AppTextStyles.color(
                  AppTextStyles.body16,
                  AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpace.s16),
              SizedBox(
                width: double.infinity,
                child: BoxCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'PROGRESO DE HOY',
                            style: AppTextStyles.label13,
                          ),
                          Text(
                            '${repo.completedCount}/${repo.totalTasks}',
                            style: AppTextStyles.body16,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpace.s8),
                      PBar(value: repo.dayProgress, color: AppColors.primary),
                      const SizedBox(height: AppSpace.s12),
                      const Divider(
                        color: AppColors.border,
                        height: 1,
                        thickness: 1,
                      ),
                      const SizedBox(height: AppSpace.s12),
                      Text('ESTA SEMANA', style: AppTextStyles.label13),
                      const SizedBox(height: AppSpace.s8),
                      const StarRow(
                        total: 5,
                        filled: 3,
                        size: AppSize.star,
                        baseDurationMs: AppMotion.starBaseMs,
                        staggerMs: AppMotion.starStaggerMs,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpace.s16),
              SizedBox(
                width: double.infinity,
                child: Btn(
                  label: 'Volver a Mi Dia',
                  onPressed: () => goDayRoot(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
