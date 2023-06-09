import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_data_usage/assets/colors/project_colors.dart';
import 'package:second_task_data_usage/assets/text_styles/project_styles.dart';
import 'package:second_task_data_usage/utils/dates_convertor.dart';

/// виджет показа даты
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
