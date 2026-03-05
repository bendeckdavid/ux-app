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
import '../widgets/progress_summary_card.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../data/mock/child_mock_repository.dart';

class RwdPg extends StatelessWidget {
  const RwdPg({super.key});

  @override
  Widget build(BuildContext context) {
    final ChildMockRepository repo = ChildMockRepository.instance;

    return CScaf(
      currentRoute: AppRoutes.day,
      child: FdScIn(
        begin: AppMotion.scaleBegin,
        duration: AppMotion.pageIn,
        curve: AppMotion.easeOut,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpace.s16,
            AppSpace.s24,
            AppSpace.s16,
            AppSpace.s16,
          ),
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
            ProgCard(
              title: 'Progreso de Hoy',
              progress: repo.dayProgress,
              counterLabel: '${repo.completedCount}/${repo.totalTasks}',
            ),
            const SizedBox(height: AppSpace.s16),
            BoxCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Esta Semana', style: AppTextStyles.body16),
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
            const SizedBox(height: AppSpace.s16),
            Btn(label: 'Volver a Mi Dia', onPressed: () => goDayRoot(context)),
          ],
        ),
      ),
    );
  }
}
