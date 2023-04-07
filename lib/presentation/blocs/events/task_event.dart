import 'package:second_task_data_usage/domain/models/sort_types.dart';
import 'package:second_task_data_usage/domain/models/task.dart';

/// базовое событие блока задач
abstract class TaskEvent {
  const TaskEvent();
}

/// событие на получение задач с бд
class GetTasksEvent extends TaskEvent {}

/// событие на сохранение задачи в бд
class SaveTaskEvent extends TaskEvent {
  final Task task;

  SaveTaskEvent({required this.task});
}

/// событие изменение флага задачи
class ChangeCompletionTaskEvent extends TaskEvent {
  final Task task;

  ChangeCompletionTaskEvent({required this.task});
}

/// событие на изменение видимости выполненных задач
class FilterEvent extends TaskEvent {}

/// событие на изменение типа сортировок
class SortEvent extends TaskEvent {
  final SortTypes sortType;

  SortEvent({required this.sortType});
}
