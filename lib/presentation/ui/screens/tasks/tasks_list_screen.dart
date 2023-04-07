import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:second_task_data_usage/assets/colors/project_colors.dart';
import 'package:second_task_data_usage/assets/icons/project_icons.dart';
import 'package:second_task_data_usage/assets/strings/projects_strings.dart';
import 'package:second_task_data_usage/assets/text_styles/project_styles.dart';
import 'package:second_task_data_usage/presentation/blocs/task_bloc.dart';
import 'package:second_task_data_usage/presentation/blocs/events/task_event.dart';
import 'package:second_task_data_usage/presentation/blocs/states/task_state.dart';
import 'package:second_task_data_usage/domain/models/sort_types.dart';
import 'package:second_task_data_usage/domain/models/task.dart';
import 'package:second_task_data_usage/presentation/ui/screens/tasks/add_task_screen.dart';
import 'package:second_task_data_usage/presentation/ui/widgets/check_box_widget.dart';
import 'package:second_task_data_usage/presentation/ui/widgets/title_with_text_btn_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ProjectColors.screenBackgroundColor,
        bottomNavigationBar: const _TasksBottomNavigationBar(),
        body: Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
                return TextTitleWithBtn(
                  title: ProjectStrings.titleList,
                  isBtn: state is GetTasksState,
                  onPressed: () {
                    context.read<TaskBloc>().add(
                          FilterEvent(),
                        );
                  },
                );
              }),
              BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
                if (state is GetTasksState) {
                  return _TasksListOfTasksWidget(
                    tasks: state.tasks,
                  );
                } else if (state is TasksEmptyState) {
                  return const _TasksNoTasksWidget();
                } else {
                  return const _LoadingWidget();
                }
              }),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const _TasksFloatingButtons(),
      ),
    );
  }
}

class _TasksBottomNavigationBar extends StatefulWidget {
  const _TasksBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<_TasksBottomNavigationBar> createState() =>
      _TasksBottomNavigationBarState();
}

class _TasksBottomNavigationBarState extends State<_TasksBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgIcon(
            icon: const SvgIconData(ProjectIcons.iBarUp),
            size: 40.h,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon(
            icon: const SvgIconData(ProjectIcons.iBarDown),
            size: 40.h,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon(
            icon: const SvgIconData(ProjectIcons.iBarDate),
            size: 40.h,
          ),
          label: '',
        ),
      ],
      selectedItemColor: ProjectColors.activeColor,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
        context.read<TaskBloc>().add(
              SortEvent(
                sortType: SortTypes.values[index],
              ),
            );
      },
    );
  }
}

class _TasksListOfTasksWidget extends StatelessWidget {
  const _TasksListOfTasksWidget({required this.tasks, Key? key})
      : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return CheckBoxWidget(
            title: tasks[index].name,
            date: tasks[index].date,
            value: tasks[index].isCompleted,
            onChanged: (bool? value) {
              context.read<TaskBloc>().add(
                    ChangeCompletionTaskEvent(
                      task: tasks[index],
                    ),
                  );
            },
          );
        },
      ),
    );
  }
}

class _TasksNoTasksWidget extends StatelessWidget {
  const _TasksNoTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 115.h,
          width: 156.w,
          child: Text(
            ProjectStrings.noTasks,
            style: ProjectStyles.semiBoldGrey15OpenSans,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 52.w, top: 18.h),
          child: Image.asset(ProjectIcons.iArrow2),
        ),
      ],
    );
  }
}

class _TasksFloatingButtons extends StatelessWidget {
  const _TasksFloatingButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "noHERO1",
            onPressed: () {
              Navigator.pushNamed(context, '/infoScreen');
            },
            backgroundColor: ProjectColors.btnColor,
            child: SvgIcon(
              icon: const SvgIconData(ProjectIcons.iInfo),
              size: 32.h,
            ),
          ),
          Expanded(child: Container()),
          FloatingActionButton(
            heroTag: "noHERO2",
            onPressed: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                ),
                context: context,
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0.r),
                      topRight: Radius.circular(25.0.r),
                    ),
                    child: Container(
                      height: 600,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const AddTaskScreen(),
                    ),
                  );
                },
              );
            },
            backgroundColor: ProjectColors.btnColor,
            child: SvgIcon(
              icon: const SvgIconData(ProjectIcons.iPlus),
              size: 32.h,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: 150.w,
          height: 150.h,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
