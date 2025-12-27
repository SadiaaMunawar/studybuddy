import 'package:cloud_firestore/cloud_firestore.dart';

/// Priority levels for tasks
enum TaskPriority { low, medium, high }

class Task {
  final String id;
  final String title;
  final String? notes;
  final DateTime dueDate;
  final TaskPriority priority;
  final bool completed;
  final String userId;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.notes,
    required this.dueDate,
    required this.priority,
    required this.completed,
    required this.userId,
    required this.createdAt,
  });

  /// Build Task from Firestore map
  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      id: id,
      title: map['title'] ?? '',
      notes: map['notes'],
      dueDate: (map['dueDate'] as Timestamp).toDate(),
      priority: TaskPriority.values[map['priority'] ?? 1],
      completed: map['completed'] ?? false,
      userId: map['userId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  /// Convert Task to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'notes': notes,
      'dueDate': Timestamp.fromDate(dueDate),
      'priority': priority.index,
      'completed': completed,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// CopyWith for safe updates
  Task copyWith({
    String? id,
    String? title,
    String? notes,
    DateTime? dueDate,
    TaskPriority? priority,
    bool? completed,
    String? userId,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Toggle completion helper
  Task toggleCompleted() => copyWith(completed: !completed);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
