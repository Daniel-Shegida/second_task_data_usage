import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_data_usage/assets/colors/project_colors.dart';

/// стили проекта
abstract class ProjectStyles {
  static TextStyle boldBlack34OpenSans = TextStyle(
    fontSize: 34.sp,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    color: ProjectColors.textColorPrimary,
  );

  static TextStyle regularBlack22OpenSans = TextStyle(
    fontSize: 22.sp,
    fontFamily: 'OpenSans',
    color: ProjectColors.textColorPrimary,
  );

  static TextStyle semiBoldBlack20OpenSans = TextStyle(
    fontSize: 20.sp,
    fontFamily: 'OpenSans',
    color: ProjectColors.textColorPrimary,
    fontWeight: FontWeight.w600,
  );

  static TextStyle semiBoldBlack17OpenSans = TextStyle(
    fontSize: 17.sp,
    fontFamily: 'OpenSans',
    color: ProjectColors.textColorPrimary,
    fontWeight: FontWeight.w600,
  );

  static TextStyle semiBoldGrey15OpenSans = TextStyle(
    fontSize: 15.sp,
    fontFamily: 'OpenSans',
    color: ProjectColors.textColorSecondary,
    fontWeight: FontWeight.w600,
  );

  static TextStyle semiBoldActive13OpenSans = TextStyle(
    fontSize: 13.sp,
    fontFamily: 'OpenSans',
    color: ProjectColors.activeColor,
    fontWeight: FontWeight.w600,
  );

  static TextStyle semiBoldActive17OpenSans = TextStyle(
    fontSize: 17.sp,
    fontFamily: 'OpenSans',
    color: ProjectColors.activeColor,
    fontWeight: FontWeight.w600,
  );

  static TextStyle semiBoldBtn14OpenSans = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'OpenSans',
    color: ProjectColors.iconColor,
    fontWeight: FontWeight.w600,
  );

  static TextStyle italicActive13OpenSans = TextStyle(
    fontSize: 13.sp,
    fontFamily: 'OpenSans',
    fontStyle: FontStyle.italic,
    color: ProjectColors.textColorSecondarySubTitle,
  );
}
