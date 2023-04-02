import 'package:second_task_data_usage/second_task/utils/sort_types.dart';

/// Basic task event.
abstract class TaskEvent {
  /// Constructor.
  const TaskEvent();
}

class GetTasksEvent extends TaskEvent {}

class SaveTaskEvent extends TaskEvent {}

class FilterEvent extends TaskEvent {
  final bool changedFilter;

  FilterEvent({required this.changedFilter});
}

class SortEvent extends TaskEvent {
  final SortTypes sortType;

  SortEvent({required this.sortType});

}