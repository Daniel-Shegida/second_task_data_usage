import 'package:second_task_data_usage/features/tasks/utils/sort_types.dart';
import 'package:second_task_data_usage/features/tasks/utils/task.dart';

/// Basic task event.
abstract class TaskEvent {
  /// Constructor.
  const TaskEvent();
}

class GetTasksEvent extends TaskEvent {}

class SaveTaskEvent extends TaskEvent {
  final Task task;

  SaveTaskEvent({required this.task});
}

class ChangeCompletionTaskEvent extends TaskEvent {
  final Task task;

  ChangeCompletionTaskEvent({required this.task});
}

class FilterEvent extends TaskEvent {}

class SortEvent extends TaskEvent {
  final SortTypes sortType;

  SortEvent({required this.sortType});
}
