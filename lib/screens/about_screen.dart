import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text(
              "Study Buddy",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "Study Buddy is designed specifically for students to work efficiently, "
              "stay organized, and manage their time properly. It helps you balance "
              "study sessions, tasks, and breaks so you can focus better and achieve more.",
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            const Text(
              "Key Features",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const ListTile(
              leading: Icon(Icons.task_alt, color: Colors.indigo),
              title: Text("Task Management"),
              subtitle: Text("Create, edit, and track tasks with deadlines and priorities."),
            ),
            const ListTile(
              leading: Icon(Icons.analytics, color: Colors.indigo),
              title: Text("Analytics"),
              subtitle: Text("Visualize your progress with charts and statistics."),
            ),
            const ListTile(
              leading: Icon(Icons.timer, color: Colors.indigo),
              title: Text("Focus Timer"),
              subtitle: Text("Use Pomodoro-style focus sessions with customizable breaks."),
            ),
            const ListTile(
              leading: Icon(Icons.notifications_active, color: Colors.indigo),
              title: Text("Smart Reminders"),
              subtitle: Text("Get notified about upcoming deadlines and study sessions."),
            ),
            const ListTile(
              leading: Icon(Icons.color_lens, color: Colors.indigo),
              title: Text("Personalization"),
              subtitle: Text("Adjust theme mode and settings to fit your style."),
            ),

            const SizedBox(height: 24),
            const Text(
              "Why Study Buddy?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text(
              "Because student life can be overwhelming, Study Buddy helps you stay on top "
              "of your schedule, reduce stress, and make the most of your study time. "
              "It’s your companion for smarter learning and better productivity.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
