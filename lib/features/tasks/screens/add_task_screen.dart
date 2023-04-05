import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_data_usage/assets/colors/project_colors.dart';
import 'package:second_task_data_usage/assets/strings/projects_strings.dart';
import 'package:second_task_data_usage/assets/text_styles/project_styles.dart';
import 'package:second_task_data_usage/features/tasks/service/task_bloc.dart';
import 'package:second_task_data_usage/features/tasks/service/task_event.dart';
import 'package:second_task_data_usage/features/tasks/utils/dates_convertor.dart';
import 'package:second_task_data_usage/features/tasks/utils/task.dart';
import 'package:second_task_data_usage/features/tasks/widgets/cupertino_like_app_bar.dart';
import 'package:second_task_data_usage/ui_kit/rounded_btn_widget.dart';
import 'package:second_task_data_usage/ui_kit/title_with_text_btn_widget.dart';
import 'package:uuid/uuid.dart';

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
                  Navigator.pop(context);
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
            context: context, initialTime: TimeOfDay.now())) ??
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
          decoration: const InputDecoration(hintText: ProjectStrings.fishShort),
        )),
      ],
    );
  }
}

class _TimeInputRawWidget extends StatelessWidget {
  const _TimeInputRawWidget(
      {required this.currentTime, required this.onTap, Key? key})
      : super(key: key);
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

class _DateInputRawWidget extends StatelessWidget {
  const _DateInputRawWidget(
      {required this.currentDate, required this.onTap, Key? key})
      : super(key: key);
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

class TimeInfoWidget extends StatelessWidget {
  const TimeInfoWidget({required this.time, Key? key}) : super(key: key);
  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColors.inputBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Text(
          DatesConvertor.convertTimeOfDay(time),
          style: ProjectStyles.regularBlack22OpenSans,
        ),
      ),
    );
  }
}

class DateInfoWidget extends StatelessWidget {
  const DateInfoWidget({required this.date, Key? key}) : super(key: key);
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColors.inputBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Text(
          DatesConvertor.convertDateTimeToDayYear(date),
          style: ProjectStyles.regularBlack22OpenSans,
        ),
      ),
    );
  }
}
