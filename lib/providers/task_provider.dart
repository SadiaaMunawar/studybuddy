import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/firestore_service.dart';
import '../services/local_storage_service.dart';
import '../services/notification_service.dart';
import '../services/auth_service.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  bool loading = false;

  /// Watch Firestore tasks in real-time
  void watch() {
    final user = AuthService.currentUser;
    if (user == null) return;
    loading = true;
    notifyListeners();

    FirestoreService.watchTasks(user.uid).listen((remote) {
      tasks = remote;
      for (final t in tasks) {
        LocalStorageService.cacheTask(t.id, t.toMap());
      }
      loading = false;
      notifyListeners();
    });
  }

  /// Manual refresh
  Future<void> refresh() async {
    final user = AuthService.currentUser;
    if (user == null) return;

    loading = true;
    notifyListeners();

    final remote = await FirestoreService.getTasks(user.uid);
    tasks = remote;
    for (final t in tasks) {
      LocalStorageService.cacheTask(t.id, t.toMap());
    }

    loading = false;
    notifyListeners();
  }

  /// Add a new task
  Future<void> addTask(Task task) async {
    await FirestoreService.addTask(task);
    await NotificationService.scheduleDeadlineReminder(
      id: task.hashCode,
      title: task.title,
      when: task.dueDate,
    );
    tasks.add(task);
    notifyListeners();
  }

  /// Update an existing task
  Future<void> updateTask(Task task) async {
    await FirestoreService.updateTask(task);
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      notifyListeners();
    }
  }

  /// ✅ Toggle completion status
  Future<void> toggleComplete(Task task) async {
    final updated = task.copyWith(completed: !task.completed);
    await FirestoreService.updateTask(updated);
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = updated;
      notifyListeners();
    }
  }

  /// Delete a task
  Future<void> deleteTask(Task task) async {
    await FirestoreService.deleteTask(task.userId, task.id);
    await LocalStorageService.removeTask(task.id);
    tasks.removeWhere((t) => t.id == task.id);
    notifyListeners();
  }

  /// Reschedule a task
  Future<void> rescheduleTask(Task task, DateTime newDate) async {
    final updated = task.copyWith(dueDate: newDate);
    await FirestoreService.updateTask(updated);
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = updated;
      notifyListeners();
    }
  }

  // Statistics
  int get completedTasks => tasks.where((t) => t.completed).length;
  int get pendingTasks => tasks.where((t) => !t.completed).length;
  int get todayTasks => tasks.where((t) => _isToday(t.dueDate)).length;
  int get overdueTasks =>
      tasks.where((t) => !t.completed && t.dueDate.isBefore(DateTime.now())).length;

  double get completionPercentage {
    if (tasks.isEmpty) return 0.0;
    return (completedTasks / tasks.length) * 100;
  }

  List<Task> get upcomingTasks {
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));
    return tasks.where((t) =>
        !t.completed && t.dueDate.isAfter(now) && t.dueDate.isBefore(nextWeek)).toList();
  }

  List<Task> get todaysPrioritizedTasks {
    final todays = tasks.where((t) => _isToday(t.dueDate) && !t.completed).toList();
    todays.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return todays;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}
