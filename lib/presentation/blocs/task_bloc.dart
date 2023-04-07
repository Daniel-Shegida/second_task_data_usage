// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_data_usage/domain/repositories/i_task_repository.dart';
import 'package:second_task_data_usage/presentation/blocs/events/task_event.dart';
import 'package:second_task_data_usage/presentation/blocs/states/task_state.dart';
import 'package:second_task_data_usage/domain/models/sort_types.dart';
import 'package:second_task_data_usage/domain/models/task.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ITaskRepository repository;

  bool _isShowingCompleted = true;
  SortTypes _currentType = SortTypes.azSort;
  List<Task> _completedTasks = [];
  List<Task> _uncompletedTasks = [];

  TaskBloc({required this.repository}) : super(InitState()) {
    on<GetTasksEvent>((event, emit) async {
      _completedTasks = await repository.getCompletedTasks();
      _uncompletedTasks = await repository.getUncompletedTasks();
      _showTasks();
    });

    on<SaveTaskEvent>((event, emit) async {
      _uncompletedTasks.add(event.task);
      _sortListBySortType(_currentType, _uncompletedTasks);
      repository.saveTask(event.task);

      emit(GetTasksState(
        tasks: _showFiltered(),
      ));
    });

    on<ChangeCompletionTaskEvent>((event, emit) async {
      _changeCompleteness(event.task);
      repository.changeCompletenessOfTask(
          event.task.copyWith(isCompleted: !event.task.isCompleted));
      _showTasks();
    });

    on<FilterEvent>((event, emit) async {
      _isShowingCompleted = !_isShowingCompleted;

      emit(
        GetTasksState(
          tasks: _showFiltered(),
        ),
      );
    });

    on<SortEvent>((event, emit) async {
      _currentType = event.sortType;
      _sortListBySortType(_currentType, _completedTasks);
      _sortListBySortType(_currentType, _uncompletedTasks);
      _showTasks();
    });
  }

  void _showTasks() {
    if (_completedTasks.isNotEmpty || _uncompletedTasks.isNotEmpty) {
      emit(GetTasksState(
        tasks: _showFiltered(),
      ));
    } else {
      emit(
        TasksEmptyState(),
      );
    }
  }

  List<Task> _showFiltered() {
    if (_isShowingCompleted) {
      return _uncompletedTasks + _completedTasks;
    } else {
      return _uncompletedTasks;
    }
  }

  void _sortListBySortType(SortTypes type, List<Task> list) {
    switch (type) {
      case SortTypes.azSort:
        _sortByAlphabet(list);
        break;
      case SortTypes.zaSort:
        _sortByReversedAlphabet(list);
        break;
      case SortTypes.dateSort:
        _sortByDate(list);
        break;
    }
  }

  void _changeCompleteness(Task task) {
    if (task.isCompleted) {
      _uncompletedTasks.add(task.copyWith(
        isCompleted: false,
      ));
      _sortListBySortType(_currentType, _uncompletedTasks);
      _deleteTaskFromList(task.id, _completedTasks);
    } else {
      _completedTasks.add(task.copyWith(
        isCompleted: true,
      ));
      _sortListBySortType(_currentType, _completedTasks);
      _deleteTaskFromList(task.id, _uncompletedTasks);
    }
  }

  void _deleteTaskFromList(String id, List<Task> list) {
    list.removeWhere((element) => element.id == id);
  }

  void _sortByAlphabet(List<Task> tasks) {
    tasks.sort(
      (a, b) => a.name.compareTo(b.name),
    );
  }

  void _sortByReversedAlphabet(List<Task> tasks) {
    tasks.sort(
      (a, b) => b.name.compareTo(a.name),
    );
  }

  void _sortByDate(List<Task> tasks) {
    tasks.sort(
      (a, b) => a.date.compareTo(
        b.date,
      ),
    );
  }
}
