import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:second_task_data_usage/domain/models/app_route_paths.dart';
import 'package:second_task_data_usage/presentation/ui/screens/info/information_screen.dart';
import 'package:second_task_data_usage/presentation/ui/screens/tasks/tasks_list_screen.dart';

/// все пути проекта
final routes = RouteMap(
  routes: {
    '/': (_) => const Redirect(AppRoutePaths.taskListScreen),
    AppRoutePaths.taskListScreen: (_) => const MaterialPage<TasksScreen>(
          child: TasksScreen(),
        ),
    '${AppRoutePaths.taskListScreen}${AppRoutePaths.infoScreen}': (_) =>
        const MaterialPage<InformationScreen>(
          child: InformationScreen(),
        ),
  },
);
