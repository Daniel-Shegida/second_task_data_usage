import 'package:second_task_data_usage/domain/models/task.dart';

/// базовое состояние блока задач
abstract class TaskState {}

class InitState extends TaskState {}

/// состояние получение новых задач
class GetTasksState extends TaskState {
  final List<Task> tasks;

  GetTasksState({required this.tasks});
}

/// состояние, если задач в бд нет
class TasksEmptyState extends TaskState {}
