import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_data_usage/features/tasks/service/rep/drift_task_repository.dart';
import 'package:second_task_data_usage/features/tasks/service/rep/i_task_repository.dart';
import 'package:second_task_data_usage/features/tasks/service/task_event.dart';
import 'package:second_task_data_usage/features/tasks/service/task_state.dart';
import 'package:second_task_data_usage/features/tasks/utils/sort_types.dart';
import 'package:second_task_data_usage/features/tasks/utils/task.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  late final ITaskRepository _rep = DriftTaskRepository();

  bool isShowingCompleted = true;
  SortTypes _currentType = SortTypes.azSort;
  List<Task> completedTasks = [];
  List<Task> uncompletedTasks = [];

  TaskBloc() : super(InitState()) {
    on<GetTasksEvent>((event, emit) async {
      completedTasks = await _rep.getCompletedTasks();
      uncompletedTasks = await _rep.getUncompletedTasks();
      showTasks();
    });

    on<SaveTaskEvent>((event, emit) async {
      uncompletedTasks.add(event.task);
      sortListBySortType(_currentType, uncompletedTasks);
      _rep.saveTask(event.task);

      emit(GetTasksState(
        tasks: showFiltered(),
      ));
    });

    on<ChangeCompletionTaskEvent>((event, emit) async {
      changeCompleteness(event.task);
      _rep.changeCompletenessOfTask(event.task);
      showTasks();
    });

    on<FilterEvent>((event, emit) async {
      isShowingCompleted = !isShowingCompleted;

      emit(
        GetTasksState(
          tasks: showFiltered(),
        ),
      );
    });

    on<SortEvent>((event, emit) async {
      _currentType = event.sortType;
      sortListBySortType(_currentType, completedTasks);
      sortListBySortType(_currentType, uncompletedTasks);
      showTasks();
    });
  }

  void showTasks() {
    if (completedTasks.isNotEmpty || uncompletedTasks.isNotEmpty) {
      emit(GetTasksState(
        tasks: showFiltered(),
      ));
    } else {
      emit(
        TasksEmptyState(),
      );
    }
  }

  List<Task> showFiltered() {
    if (isShowingCompleted) {
      return uncompletedTasks + completedTasks;
    } else {
      return uncompletedTasks;
    }
  }

  void sortListBySortType(SortTypes type, List<Task> list) {
    switch (type) {
      case SortTypes.azSort:
        sortByAlphabet(list);
        break;
      case SortTypes.zaSort:
        sortByReversedAlphabet(list);
        break;
      case SortTypes.dateSort:
        sortByDate(list);
        break;
    }
  }

  void changeCompleteness(Task task) {
    if (task.isCompleted) {
      uncompletedTasks.add(task.copyWith(
        isCompleted: false,
      ));
      sortListBySortType(_currentType, uncompletedTasks);
      deleteTaskFromList(task.id, completedTasks);
    } else {
      completedTasks.add(task.copyWith(
        isCompleted: true,
      ));
      sortListBySortType(_currentType, completedTasks);
      deleteTaskFromList(task.id, uncompletedTasks);
    }
  }

  void deleteTaskFromList(String id, List<Task> list) {
    list.removeWhere((element) => element.id == id);
  }

  void sortByAlphabet(List<Task> tasks) {
    tasks.sort(
      (a, b) => a.name.compareTo(b.name),
    );
  }

  void sortByReversedAlphabet(List<Task> tasks) {
    tasks.sort(
      (a, b) => b.name.compareTo(a.name),
    );
  }

  void sortByDate(List<Task> tasks) {
    tasks.sort(
      (a, b) => a.date.compareTo(
        b.date,
      ),
    );
  }
}
