import '../widgets/page_entrance.dart';
import 'package:flutter/material.dart';
import '../../../app/router.dart';
import '../widgets/child_navigation.dart';
import '../widgets/child_icon_button.dart';
import '../widgets/child_page_header.dart';
import '../widgets/child_surface_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_input.dart';
import '../../../core/widgets/tap_scale.dart';
import '../widgets/child_success_header.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/activity_icon.dart';
import '../../../src/alarm/alarm_notification_service.dart';

class AlmNewPg extends StatefulWidget {
  const AlmNewPg({super.key});

  @override
  State<AlmNewPg> createState() => _CreateAlarmPageState();
}

class _CreateAlarmPageState extends State<AlmNewPg> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Ver mi Show Favorito',
  );
  final AlarmNotificationService _alarmService =
      AlarmNotificationService.instance;

  int step = 1;
  int hour = 4;
  int minutes = 0;
  bool isPm = true;
  String selectedIcon = 'tv';
  bool _saving = false;

  static const List<String> _iconOptions = <String>[
    'sport',
    'tv',
    'game',
    'art',
    'music',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleTimeUp() {
    setState(() {
      minutes += 15;
      if (minutes >= 60) {
        minutes = 0;
        hour += 1;
      }
      if (hour > 12) {
        hour = 1;
        isPm = !isPm;
      }
    });
  }

  void _handleTimeDown() {
    setState(() {
      minutes -= 15;
      if (minutes < 0) {
        minutes = 45;
        hour -= 1;
      }
      if (hour < 1) {
        hour = 12;
        isPm = !isPm;
      }
    });
  }

  String get _timeLabel {
    final String mm = minutes.toString().padLeft(2, '0');
    return '$hour:$mm ${isPm ? 'PM' : 'AM'}';
  }

  DateTime _nextAlarmDateTime() {
    final DateTime now = DateTime.now();
    final int hour24 = isPm ? (hour % 12) + 12 : (hour % 12);

    DateTime candidate = DateTime(
      now.year,
      now.month,
      now.day,
      hour24,
      minutes,
    );
    if (!candidate.isAfter(now)) {
      candidate = candidate.add(const Duration(days: 1));
    }

    return candidate;
  }

  Future<void> _createAlarm() async {
    final String name = _nameController.text.trim();
    if (name.isEmpty || _saving) return;

    setState(() => _saving = true);
    try {
      final AlarmPermissionStatus permissions = await _alarmService
          .ensureAlarmPermissions();
      if (!permissions.canScheduleAlarm) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Activa permisos para crear la alarma')),
        );
        return;
      }

      await _alarmService.scheduleAlarm(
        alarmId: 20001,
        when: _nextAlarmDateTime(),
        payload: AppRoutes.alarm,
        title: name,
        body: 'No olvides completar la actividad',
      );

      if (!mounted) return;
      setState(() => step = 2);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo crear la alarma')),
      );
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: PgIn(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.s16,
              AppSpace.s12,
              AppSpace.s16,
              AppSpace.s16,
            ),
            children: <Widget>[
              PgHead(
                onBack: () => popOrGoDay(context),
                title: 'Mi Alarma Nueva',
              ),
              const SizedBox(height: AppSpace.s16),
              AnimatedSwitcher(
                duration: AppMotion.switcher,
                child: step == 1 ? _buildFormStep() : _buildSuccessStep(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormStep() {
    return Column(
      key: const ValueKey<int>(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Sec(
          label: 'Hora',
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IBtn(icon: Icons.keyboard_arrow_up, onTap: _handleTimeUp),
                  const SizedBox(width: AppSpace.s8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpace.s20,
                      vertical: AppSpace.s12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadius.r16),
                      border: Border.all(
                        color: AppColors.border,
                        width: AppBorderW.base,
                      ),
                    ),
                    child: Text(_timeLabel, style: AppTextStyles.title24),
                  ),
                  const SizedBox(width: AppSpace.s8),
                  IBtn(icon: Icons.keyboard_arrow_down, onTap: _handleTimeDown),
                ],
              ),
              const SizedBox(height: AppSpace.s8),
              Wrap(
                spacing: AppSpace.s8,
                children: <Widget>[
                  _AmPmBtn(
                    label: 'AM',
                    active: !isPm,
                    onTap: () => setState(() => isPm = false),
                  ),
                  _AmPmBtn(
                    label: 'PM',
                    active: isPm,
                    onTap: () => setState(() => isPm = true),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.s12),
        _Sec(
          label: 'Actividad',
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _iconOptions.map((String iconKey) {
                final bool active = selectedIcon == iconKey;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpace.s8),
                  child: TScale(
                    onTap: () => setState(() => selectedIcon = iconKey),
                    child: Container(
                      padding: const EdgeInsets.all(AppSpace.s8),
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.primarySoft
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.r12),
                        border: Border.all(
                          color: active ? AppColors.primary : AppColors.border,
                          width: active ? AppBorderW.active : AppBorderW.base,
                        ),
                      ),
                      child: AIcon(iconKey: iconKey, size: AIconSz.md),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: AppSpace.s12),
        _Sec(
          label: 'Nombre',
          child: Inp(
            controller: _nameController,
            textAlign: TextAlign.center,
            onChanged: (_) => setState(() {}),
          ),
        ),
        const SizedBox(height: AppSpace.s16),
        Btn(
          label: _saving ? 'Guardando...' : 'Crear Mi Alarma',
          onPressed: _nameController.text.trim().isEmpty || _saving
              ? null
              : _createAlarm,
        ),
      ],
    );
  }

  Widget _buildSuccessStep() {
    return Column(
      key: const ValueKey<int>(2),
      children: <Widget>[
        OkHead(
          title: 'Alarma Creada',
          subtitle: 'Te avisare a las $_timeLabel',
        ),
        const SizedBox(height: AppSpace.s16),
        BoxCard(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              AIcon(iconKey: selectedIcon, size: AIconSz.lg),
              const SizedBox(height: AppSpace.s8),
              Text(_nameController.text, style: AppTextStyles.body16),
              const SizedBox(height: AppSpace.s4),
              Text('$_timeLabel — Hoy', style: AppTextStyles.label13),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.s16),
        Btn(label: 'Ver Mis Alarmas', onPressed: () => goDayRoot(context)),
        const SizedBox(height: AppSpace.s8),
        Btn(
          label: 'Volver',
          variant: BtnVar.secondary,
          onPressed: () => goDayRoot(context),
        ),
      ],
    );
  }
}

class _Sec extends StatelessWidget {
  const _Sec({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text(
            label.toUpperCase(),
            style: AppTextStyles.label13,
          ),
        ),
        const SizedBox(height: AppSpace.s8),
        child,
      ],
    );
  }
}

class _AmPmBtn extends StatelessWidget {
  const _AmPmBtn({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.s12,
          vertical: AppSpace.s8,
        ),
        decoration: BoxDecoration(
          color: active ? AppColors.primarySoft : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.r12),
          border: Border.all(
            color: active ? AppColors.primary : AppColors.border,
            width: active ? AppBorderW.active : AppBorderW.base,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.color(
            AppTextStyles.label13,
            active ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
