import 'package:flutter/material.dart';
import 'package:second_task_data_usage/assets/colors/project_colors.dart';

abstract class ProjectStyles {
  static const TextStyle boldBlack34_41OpenSans = TextStyle(
    fontSize: 34,
    height: 41,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    color: ProjectColors.textColorPrimary,
  );

  static const TextStyle regularBlack20_24OpenSans = TextStyle(
    fontSize: 20,
    height: 24,
    fontFamily: 'OpenSans',
    color: ProjectColors.textColorPrimary,
  );

  static const TextStyle regularGrey15_20OpenSans = TextStyle(
    fontSize: 15,
    height: 20,
    fontFamily: 'OpenSans',
    color: ProjectColors.textColorSecondary,
  );

  static const TextStyle regularActive13_17OpenSans = TextStyle(
    fontSize: 13,
    height: 17.7,
    fontFamily: 'OpenSans',
    color: ProjectColors.activeColor,
  );

  static const TextStyle regularActive17_22OpenSans = TextStyle(
    fontSize: 17,
    height: 22,
    fontFamily: 'OpenSans',
    color: ProjectColors.activeColor,
  );
}
