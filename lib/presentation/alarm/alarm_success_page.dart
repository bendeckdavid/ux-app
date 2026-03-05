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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: PgIn(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.s16,
              AppSpace.s24,
              AppSpace.s16,
              AppSpace.s16,
            ),
            children: <Widget>[
              const Center(
                child: OkHead(
                  title: 'Actividad Completada',
                  subtitle: 'Mochila lista para la escuela',
                  badgeSize: AppSize.heroBadge,
                  badgeIconSize: AppSize.heroBadgeIcon,
                ),
              ),
              const SizedBox(height: AppSpace.s16),
              const ProgCard(
                title: 'Progreso de Rutina',
                progress: 1,
                counterLabel: '4/4',
                footnote: 'Rutina Completa',
              ),
              const SizedBox(height: AppSpace.s16),
              Btn(label: 'Ver Mi Dia', onPressed: () => goDayRoot(context)),
            ],
          ),
        ),
      ),
    );
  }
}
