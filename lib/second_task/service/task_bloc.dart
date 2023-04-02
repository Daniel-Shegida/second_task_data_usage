import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_data_usage/second_task/service/re/i_task_repository.dart';
import 'package:second_task_data_usage/second_task/service/re/testRep.dart';
import 'package:second_task_data_usage/second_task/service/task_event.dart';
import 'package:second_task_data_usage/second_task/service/task_state.dart';
import 'package:second_task_data_usage/second_task/utils/classes.dart';
import 'package:second_task_data_usage/second_task/utils/sort_types.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  late final ITaskRepository _rep = TEST();

  bool isShowingCompleted = true;
  List<Task> completedTasks = [];
  List<Task> uncompletedTasks = [];

  TaskBloc(
      // this._rep
      ) : super(InitState()) {
    on<GetTasksEvent>((event, emit) async {
       completedTasks = _rep.getTasks();
      print('daq');

      emit(GetTasksState(tasks: showFiltered(),));
    });

    on<SaveTaskEvent>((event, emit) async {

    });

    on<FilterEvent>((event, emit) async {
      isShowingCompleted = event.changedFilter;

      emit(GetTasksState(tasks: showFiltered(),),);
    });

    on<SortEvent>((event, emit) async {
      switch (event.sortType){
        case SortTypes.azSort:
          emit(GetTasksState(tasks: showFiltered(),),);
          break;
        case SortTypes.zaSort:
          emit(GetTasksState(tasks: showFiltered(),),);
          break;
        case SortTypes.dateSort:
          emit(GetTasksState(tasks: showFiltered(),),);
          break;
      }

      emit(GetTasksState(tasks: showFiltered(),),);


    });
  }

  List<Task> showFiltered(){
    if(isShowingCompleted){
      return completedTasks + uncompletedTasks;
    }
    else {
      return completedTasks;
    }
  }
}