import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:second_task_data_usage/data/datasourses/firebase/firebase_remote_data_sourse.dart';
import 'package:second_task_data_usage/data/repositories/firestore_task_repository.dart';
import 'package:second_task_data_usage/domain/blocs/events/task_event.dart';
import 'package:second_task_data_usage/domain/blocs/task_bloc.dart';
import 'package:second_task_data_usage/domain/models/app_routes.dart';

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
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (_) => routes,
            ),
            routeInformationParser: const RoutemasterParser(),
          );
        },
      ),
    );
  }
}
