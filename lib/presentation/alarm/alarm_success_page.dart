import '../widgets/page_entrance.dart';
import 'package:flutter/material.dart';
import '../widgets/child_navigation.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../widgets/child_success_header.dart';
import '../../../core/widgets/app_button.dart';
import '../widgets/progress_summary_card.dart';

class AlmOkPg extends StatelessWidget {
  const AlmOkPg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: PgIn(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpace.s24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const OkHead(
                    title: 'Actividad Completada',
                    subtitle: 'Mochila lista para la escuela',
                    badgeSize: AppSize.heroBadge,
                    badgeIconSize: AppSize.heroBadgeIcon,
                    titleSize: 22,
                    subtitleSize: 16,
                  ),
                  const SizedBox(height: AppSpace.s16),
                  const SizedBox(
                    width: double.infinity,
                    child: ProgCard(
                      title: 'Progreso de Rutina',
                      progress: 1,
                      counterLabel: '4/4',
                      footnote: 'Rutina Completa',
                    ),
                  ),
                  const SizedBox(height: AppSpace.s16),
                  SizedBox(
                    width: double.infinity,
                    child: Btn(
                      label: 'Ver Mi Dia',
                      onPressed: () => goDayRoot(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
