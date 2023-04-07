import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_data_usage/features/info/screens/information_screen.dart';
import 'package:second_task_data_usage/features/tasks/screens/tasks_list_screen.dart';
import 'package:second_task_data_usage/features/tasks/service/task_bloc.dart';
import 'package:second_task_data_usage/features/tasks/service/task_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider<TaskBloc>(
      create: (BuildContext context) => TaskBloc()..add(GetTasksEvent()),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        useInheritedMediaQuery: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const TasksScreen(),
              '/infoScreen': (context) => const InformationScreen(),
            },
          );
        },
      ),
    );
  }
}