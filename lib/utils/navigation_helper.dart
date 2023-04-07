import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:second_task_data_usage/domain/models/app_route_paths.dart';

/// Модель унифицирующая навигацию между экранами
class NavigationHelper {
  /// Метод перехода на экран информации
  void moveToInfoScreen(
    BuildContext context,
  ) {
    Routemaster.of(context).push(
      AppRoutePaths.infoScreen,
    );
  }
}
