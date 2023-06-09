import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:second_task_data_usage/assets/strings/projects_strings.dart';
import 'package:second_task_data_usage/assets/text_styles/project_styles.dart';
import 'package:second_task_data_usage/domain/blocs/events/task_event.dart';
import 'package:second_task_data_usage/domain/blocs/task_bloc.dart';
import 'package:second_task_data_usage/domain/models/task.dart';
import 'package:second_task_data_usage/presentation/ui/widgets/cupertino_like_app_bar.dart';
import 'package:second_task_data_usage/presentation/ui/widgets/date_info_widget.dart';
import 'package:second_task_data_usage/presentation/ui/widgets/rounded_btn_widget.dart';
import 'package:second_task_data_usage/presentation/ui/widgets/time_info_widget.dart';
import 'package:second_task_data_usage/presentation/ui/widgets/title_with_text_btn_widget.dart';
import 'package:uuid/uuid.dart';

/// экран добавления новых задач
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _textEditingController;
  TimeOfDay _currentTime = TimeOfDay.now();
  DateTime _currentDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoLikeAppbar(),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 14.w, top: 0.h),
        child: Column(
          children: [
            const TextTitleWithBtn(
              title: ProjectStrings.titleAdd,
              isBtn: false,
            ),
            Form(
              key: _formKey,
              child: _TextInputRawWidget(
                textEditingController: _textEditingController,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            _TimeInputRawWidget(
              currentTime: _currentTime,
              onTap: _changeTimeByDialog,
            ),
            SizedBox(
              height: 28.h,
            ),
            _DateInputRawWidget(
              currentDate: _currentDate,
              onTap: _changeDateByDialog,
            ),
            SizedBox(
              height: 57.h,
            ),
            RoundedBtnWidget(
              bntText: ProjectStrings.btnDone,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<TaskBloc>().add(
                        SaveTaskEvent(
                          task: Task(
                            id: const Uuid().v1(),
                            name: _textEditingController.text,
                            date: _currentDate.copyWith(
                              hour: _currentTime.hour,
                              minute: _currentTime.minute,
                            ),
                          ),
                        ),
                      );
                  Routemaster.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _changeTimeByDialog() async {
    _currentTime = (await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        )) ??
        _currentTime;
    setState(() {});
  }

  void _changeDateByDialog() async {
    _currentDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
        ) ??
        _currentDate;
    setState(() {});
  }
}

/// виджет колонки набора текста
class _TextInputRawWidget extends StatelessWidget {
  const _TextInputRawWidget({required this.textEditingController, Key? key})
      : super(key: key);
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ProjectStrings.infoName,
          style: ProjectStyles.semiBoldBlack20OpenSans,
        ),
        SizedBox(
          width: 11.w,
        ),
        Expanded(
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: textEditingController,
            decoration:
                const InputDecoration(hintText: ProjectStrings.fishShort),
          ),
        ),
      ],
    );
  }
}

/// виджет колонки выбора времени
class _TimeInputRawWidget extends StatelessWidget {
  const _TimeInputRawWidget({
    required this.currentTime,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final TimeOfDay currentTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ProjectStrings.infoTime,
          style: ProjectStyles.semiBoldBlack20OpenSans,
        ),
        SizedBox(
          width: 22.w,
        ),
        InkWell(
          onTap: onTap,
          child: TimeInfoWidget(
            time: currentTime,
          ),
        ),
      ],
    );
  }
}

/// виджет колонки выбора даты
class _DateInputRawWidget extends StatelessWidget {
  const _DateInputRawWidget({
    required this.currentDate,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final DateTime currentDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ProjectStrings.infoDate,
          style: ProjectStyles.semiBoldBlack20OpenSans,
        ),
        SizedBox(
          width: 24.w,
        ),
        InkWell(
          onTap: onTap,
          child: DateInfoWidget(
            date: currentDate,
          ),
        ),
      ],
    );
  }
}
