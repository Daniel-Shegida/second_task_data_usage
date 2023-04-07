import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_data_usage/data/datasourses/firebase/firebase_remote_data_sourse.dart';
import 'package:second_task_data_usage/data/repositories/firestore_task_repository.dart';
import 'package:second_task_data_usage/presentation/blocs/task_bloc.dart';
import 'package:second_task_data_usage/presentation/blocs/events/task_event.dart';
import 'package:second_task_data_usage/presentation/ui/screens/info/information_screen.dart';
import 'package:second_task_data_usage/presentation/ui/screens/tasks/tasks_list_screen.dart';

/// иницилизация приложения
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (BuildContext _) => TaskBloc(
        repository: FirestoreTaskRepository(
          dataSource: FirebaseRemoteDataSource(),
        ),
      )..add(
          GetTasksEvent(),
        ),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        useInheritedMediaQuery: true,
        builder: (_, __) {
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
