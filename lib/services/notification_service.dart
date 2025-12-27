import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationService {
  static final _fln = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tzdata.initializeTimeZones();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _fln.initialize(initSettings);
  }

  static Future<void> scheduleDeadlineReminder({
    required int id,
    required String title,
    required DateTime when,
  }) async {
    await _fln.zonedSchedule(
      id,
      'Upcoming deadline',
      title,
      tz.TZDateTime.from(when, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'deadlines_channel',
          'Deadlines',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  static Future<void> showDailyReminder(int id, String body) async {
    await _fln.show(
      id,
      'Study Reminder',
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel',
          'Daily',
          importance: Importance.defaultImportance,
        ),
      ),
    );
  }
}
