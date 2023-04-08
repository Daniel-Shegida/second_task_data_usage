import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_data_usage/assets/strings/projects_strings.dart';
import 'package:second_task_data_usage/assets/text_styles/project_styles.dart';

/// виджет заголовка с возможной кнопкой
class TextTitleWithBtn extends StatelessWidget {
  const TextTitleWithBtn({
    required this.title,
    required this.isBtn,
    this.value = false,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final bool isBtn;
  final bool value;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 22.9.h, bottom: 26.h),
      child: Row(
        children: [
          Text(
            title,
            style: ProjectStyles.boldBlack34OpenSans,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Container(),
          ),
          if (isBtn) ...[
            Center(
              child: TextButton(
                onPressed: onPressed,
                child: Text(
                  value ? ProjectStrings.btnHide : ProjectStrings.btnShow,
                  style: ProjectStyles.semiBoldActive13OpenSans,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
