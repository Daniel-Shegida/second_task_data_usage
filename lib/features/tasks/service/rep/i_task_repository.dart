import 'package:second_task_data_usage/features/tasks/utils/task.dart';

abstract class ITaskRepository{

  void saveTask(Task task);

  void changeCompletenessOfTask(Task task);

  Future<List<Task>> getCompletedTasks();

  Future<List<Task>> getUncompletedTasks();

}