import '../../../app/router.dart';
import '../widgets/page_entrance.dart';
import 'package:flutter/material.dart';
import '../widgets/child_scaffold.dart';
import '../widgets/child_note_card.dart';
import '../widgets/child_navigation.dart';
import '../widgets/child_page_header.dart';
import '../widgets/child_surface_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/tap_scale.dart';
import '../../../core/widgets/app_button.dart';
import '../../domain/models/child_models.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/activity_icon.dart';
import '../../data/mock/child_mock_repository.dart';

class ActPg extends StatelessWidget {
  const ActPg({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    final ChildMockRepository repo = ChildMockRepository.instance;
    final ChildTask? task = repo.getTaskById(taskId);

    if (task == null) {
      return const Scaffold(
        body: Center(child: Text('Actividad no encontrada')),
      );
    }

    void complete() {
      repo.completeTask(task.id);
      Navigator.of(context).pushReplacementNamed(AppRoutes.reward);
    }

    return CScaf(
      currentRoute: AppRoutes.day,
      child: PgIn(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpace.s16,
            AppSpace.s12,
            AppSpace.s16,
            AppSpace.s16,
          ),
          children: <Widget>[
            PgHead(onBack: () => popOrGoDay(context)),
            const SizedBox(height: AppSpace.s16),
            BoxCard(
              padding: const EdgeInsets.all(AppSpace.s16),
              radius: AppRadius.r20,
              child: Column(
                children: <Widget>[
                  AIcon(iconKey: task.iconKey, size: AIconSz.xl),
                  const SizedBox(height: AppSpace.s8),
                  Text(
                    task.title,
                    style: AppTextStyles.title22,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpace.s4),
                  Text(task.timeLabel, style: AppTextStyles.label14),
                  const SizedBox(height: AppSpace.s16),
                  TScale(
                    minScale: AppMotion.tapStrongScale,
                    onTap: complete,
                    child: Container(
                      width: AppSize.checkAction,
                      height: AppSize.checkAction,
                      decoration: BoxDecoration(
                        color: AppColors.successSoft,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.success,
                          width: AppBorderW.active,
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.success,
                        size: AppSize.iconCheckLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpace.s8),
                  Text('Toca para completar', style: AppTextStyles.label13),
                ],
              ),
            ),
            const SizedBox(height: AppSpace.s12),
            NoteCard(text: task.note ?? 'Hazlo con cuidado y buena energia'),
            const SizedBox(height: AppSpace.s16),
            Btn(label: 'Termine', onPressed: complete),
          ],
        ),
      ),
    );
  }
}
