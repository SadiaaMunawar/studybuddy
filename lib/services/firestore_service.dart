import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  static final _db = FirebaseFirestore.instance;

  static Stream<List<Task>> watchTasks(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .orderBy('dueDate')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromMap(doc.data(), doc.id)).toList());
  }

  static Future<List<Task>> getTasks(String userId) async {
    final snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .orderBy('dueDate')
        .get();

    return snapshot.docs
        .map((doc) => Task.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<void> addTask(Task task) async {
    await _db
        .collection('users')
        .doc(task.userId)
        .collection('tasks')
        .add(task.toMap());
  }

  static Future<void> updateTask(Task task) async {
    await _db
        .collection('users')
        .doc(task.userId)
        .collection('tasks')
        .doc(task.id)
        .update(task.toMap());
  }

  static Future<void> deleteTask(String userId, String taskId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}
