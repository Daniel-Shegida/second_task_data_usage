class Task {
  final String id;
  final String name;
  final DateTime date;
  bool isCompleted;

  Task(
      {required this.id,
      required this.name,
      required this.date,
      this.isCompleted = false});

  Task copyWith({
    String? id,
    String? name,
    DateTime? date,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
