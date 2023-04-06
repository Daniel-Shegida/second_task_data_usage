import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_task_data_usage/features/tasks/service/rep/i_task_repository.dart';
import 'package:second_task_data_usage/features/tasks/utils/task.dart';

class FirestoreTaskRepository extends ITaskRepository {
  final firebaseTaskCollection =
      FirebaseFirestore.instance.collection('Ftasks').withConverter<Task>(
            fromFirestore: (snapshots, _) => Task.fromJson(snapshots.data()!),
            toFirestore: (task, _) => task.toJson(),
          );

  @override
  Future<List<Task>> getCompletedTasks() async {
    final taskSnapshot = await firebaseTaskCollection
        .orderBy('name')
        .where('isCompleted', isEqualTo: true)
        .get();
    return taskSnapshot.docs
        .map(
          (e) => e.data(),
        )
        .toList();
  }

  @override
  Future<List<Task>> getUncompletedTasks() async {
    final taskSnapshot = await firebaseTaskCollection
        .orderBy('name')
        .where('isCompleted', isEqualTo: false)
        .get();
    return taskSnapshot.docs
        .map(
          (e) => e.data(),
        )
        .toList();
  }

  @override
  void saveTask(Task task) {
    final taskDoc = firebaseTaskCollection.doc(task.id);
    taskDoc.set(task);
  }

  @override
  void changeCompletenessOfTask(Task task) {
    final taskDoc = firebaseTaskCollection.doc(task.id);
    taskDoc.update({'isCompleted': task.isCompleted});
  }
}
