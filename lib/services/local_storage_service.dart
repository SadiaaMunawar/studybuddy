import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const tasksBox = 'tasks_box';
  static const favoritesBox = 'favorites_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(tasksBox);
    await Hive.openBox(favoritesBox);
  }

  static Box get _tasks => Hive.box(tasksBox);
  static Box get _favorites => Hive.box(favoritesBox);

  static Future<void> cacheTask(String id, Map<String, dynamic> map) async {
    await _tasks.put(id, map);
  }

  static Map<String, dynamic>? getTask(String id) => _tasks.get(id);

  static List<Map<String, dynamic>> getAllTasks() =>
      _tasks.values.cast<Map>().map((e) => Map<String, dynamic>.from(e)).toList();

  static Future<void> removeTask(String id) async => _tasks.delete(id);

  static Future<void> setFavoriteWord(String word, bool fav) async {
    await _favorites.put(word, fav);
  }

  static bool isFavorite(String word) => _favorites.get(word, defaultValue: false);
}
