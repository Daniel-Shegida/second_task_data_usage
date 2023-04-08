import 'package:drift/drift.dart';

/// таблица задач
class DbTask extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  DateTimeColumn get date => dateTime()();

  BoolColumn get isCompleted => boolean()();
}