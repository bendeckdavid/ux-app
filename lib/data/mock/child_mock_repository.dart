import '../../domain/models/child_models.dart';

class ChildMockRepository {
  ChildMockRepository._();

  static final ChildMockRepository instance = ChildMockRepository._();

  final ChildProfile childProfile = const ChildProfile(
    id: 'child_juan_01',
    name: 'Juan',
    dayTypeLabel: 'Dia de Escuela',
    dateLabel: 'Lunes, 7 de Feb',
    streakDays: 3,
    motivationalLine: 'Vas super bien, te faltan poquitas tareas.',
  );

  final List<ChildTask> _tasks = <ChildTask>[
    const ChildTask(
      id: 't1',
      title: 'Cepillarse',
      timeLabel: '7:00 AM',
      status: TaskStatus.completed,
      iconKey: 'brush',
    ),
    const ChildTask(
      id: 't2',
      title: 'Tender Cama',
      timeLabel: '7:10 AM',
      status: TaskStatus.active,
      iconKey: 'bed',
      note: 'Estira bien las sabanas y acomoda la almohada',
    ),
    const ChildTask(
      id: 't3',
      title: 'Desayunar',
      timeLabel: '7:20 AM',
      status: TaskStatus.pending,
      iconKey: 'food',
    ),
    const ChildTask(
      id: 't4',
      title: 'Empacar Mochila',
      timeLabel: '7:30 AM',
      status: TaskStatus.pending,
      iconKey: 'backpack',
      note: 'No olvides tu lonchera y el libro de matematicas',
    ),
  ];

  final AchievementProgress achievements = const AchievementProgress(
    title: 'Gran Semana',
    weekStarsFilled: 4,
    weekStarsTotal: 5,
    medals: <AchievementMedal>[
      AchievementMedal(
        id: 'm1',
        label: 'Punteria',
        iconKey: 'target',
        toneKey: 'red',
      ),
      AchievementMedal(
        id: 'm2',
        label: 'Madrugador',
        iconKey: 'alarm',
        toneKey: 'orange',
      ),
      AchievementMedal(
        id: 'm3',
        label: 'Estrella',
        iconKey: 'sparkles',
        toneKey: 'violet',
      ),
    ],
    nextMedalName: 'Super Estrella',
    current: 20,
    target: 25,
  );

  ChildAlarm alarm = const ChildAlarm(
    id: 'a1',
    title: 'Ver mi Show Favorito',
    timeHour12: 4,
    minutes: 0,
    isPm: true,
    iconKey: 'tv',
    enabled: true,
  );

  List<ChildTask> getTasks() => List<ChildTask>.from(_tasks);

  ChildTask? getTaskById(String id) {
    for (final ChildTask task in _tasks) {
      if (task.id == id) return task;
    }
    return null;
  }

  int get completedCount => _tasks
      .where((ChildTask task) => task.status == TaskStatus.completed)
      .length;

  int get totalTasks => _tasks.length;

  double get dayProgress => totalTasks == 0 ? 0 : completedCount / totalTasks;

  String get streakLabel =>
      childProfile.streakDays == 1
          ? '1 dia seguido'
          : '${childProfile.streakDays} dias seguidos';

  void completeTask(String id) {
    final int index = _tasks.indexWhere((ChildTask task) => task.id == id);
    if (index == -1) return;

    final ChildTask current = _tasks[index];
    if (current.status == TaskStatus.completed) return;

    _tasks[index] = current.copyWith(status: TaskStatus.completed);
    if (current.status != TaskStatus.active) return;

    for (int i = 0; i < _tasks.length; i++) {
      if (_tasks[i].status == TaskStatus.active) {
        _tasks[i] = _tasks[i].copyWith(status: TaskStatus.pending);
      }
    }

    final int nextPending = _tasks.indexWhere(
      (ChildTask task) => task.status == TaskStatus.pending,
    );
    if (nextPending == -1) return;

    _tasks[nextPending] = _tasks[nextPending].copyWith(
      status: TaskStatus.active,
    );
  }
}
