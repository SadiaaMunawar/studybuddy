import 'package:flutter/material.dart';
import '../providers/user_provider.dart';
import '../models/task.dart';
import '../models/study_plan.dart';
import '../models/flashcard.dart';
import '../models/resource.dart';
import '../screens/analytics_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/dictionary_screen.dart';
import '../screens/flashcard_screen.dart';
import '../screens/focus_timer_screen.dart';
import '../screens/resource_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/study_plan_screen.dart';
import '../screens/task_editor_screen.dart';

class DashboardDrawer extends StatelessWidget {
  final UserProvider userProvider;
  final List<Task> tasks;
  final List<StudyPlan> studyPlans;
  final List<Flashcard> flashcards;
  final List<Resource> resources;

  const DashboardDrawer({
    super.key,
    required this.userProvider,
    required this.tasks,
    required this.studyPlans,
    required this.flashcards,
    required this.resources,
  });

  @override
  Widget build(BuildContext context) {
    final user = userProvider.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (user != null)
            UserAccountsDrawerHeader(
              accountName: Text(
                user.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : 'S',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          _drawerItem(context, 'Dashboard', Icons.dashboard, () {
            Navigator.pop(context);
          }),
          _drawerItem(context, 'Study Plans', Icons.schedule, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StudyPlanScreen()),
            );
          }),
          _drawerItem(context, 'Tasks', Icons.task, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TaskEditorScreen()),
            );
          }),
          _drawerItem(context, 'Focus Timer', Icons.timer, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FocusTimerScreen()),
            );
          }),
          _drawerItem(context, 'Flashcards', Icons.lightbulb, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FlashcardScreen()),
            );
          }),
          _drawerItem(context, 'Resources', Icons.library_books, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ResourceScreen()),
            );
          }),
          _drawerItem(context, 'Dictionary', Icons.book, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DictionaryScreen()),
            );
          }),
          _drawerItem(context, 'Calendar', Icons.calendar_today, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CalendarScreen()),
            );
          }),
          _drawerItem(context, 'Analytics', Icons.bar_chart, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
            );
          }),
          _drawerItem(context, 'Settings', Icons.settings, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
          }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              userProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
