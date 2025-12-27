import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _notificationsEnabled = false;
  Timer? _reminderTimer;

  final List<String> _reminders = [
    "Time to review your flashcards!",
    "Stay focused — try a Pomodoro session.",
    "Check your study plan for today.",
    "Upcoming tasks need your attention.",
    "Take a short break and hydrate.",
  ];

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });

    if (_notificationsEnabled) {
      _startReminders();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notifications enabled")),
      );
    } else {
      _reminderTimer?.cancel();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notifications disabled")),
      );
    }
  }

  void _startReminders() {
    _reminderTimer?.cancel();
    _reminderTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_notificationsEnabled) {
        final randomReminder =
            _reminders[Random().nextInt(_reminders.length)];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(randomReminder)),
        );
      }
    });
  }

  @override
  void dispose() {
    _reminderTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Enable Notifications"),
              subtitle: const Text("Get reminders for tasks and study plans"),
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
              activeColor: Colors.indigo,
            ),
            const SizedBox(height: 20),
            if (_notificationsEnabled)
              const Text(
                "Notifications are ON. You'll get reminders every few seconds.",
                style: TextStyle(color: Colors.green),
              )
            else
              const Text(
                "Notifications are OFF. Enable them to receive reminders.",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
