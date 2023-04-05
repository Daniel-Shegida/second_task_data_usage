import 'package:second_task_data_usage/features/tasks/utils/task.dart';

abstract class TaskState {}

class InitState extends TaskState {}

class GetTasksState extends TaskState {
  final List<Task> tasks;

  GetTasksState({required this.tasks});
}

class TasksEmptyState extends TaskState {}
