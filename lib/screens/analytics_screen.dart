import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for now — later you can connect with TaskProvider or database
    final int completedTasks = 12;
    final int pendingTasks = 5;
    final int studyHours = 34;

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Study Analytics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Quick stats cards
            Row(
              children: [
                _StatCard(
                  label: 'Completed',
                  value: '$completedTasks',
                  color: Colors.green,
                  icon: Icons.check_circle,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: 'Pending',
                  value: '$pendingTasks',
                  color: Colors.orange,
                  icon: Icons.pending,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: 'Study Hours',
                  value: '$studyHours',
                  color: Colors.indigo,
                  icon: Icons.access_time,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Progress chart placeholder
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    '📊 Progress Chart Coming Soon',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Recent activity list
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.book, color: Colors.indigo),
                    title: Text('Math Revision'),
                    subtitle: Text('2 hours • Completed'),
                  ),
                  ListTile(
                    leading: Icon(Icons.book, color: Colors.indigo),
                    title: Text('Physics Practice'),
                    subtitle: Text('1.5 hours • Pending'),
                  ),
                  ListTile(
                    leading: Icon(Icons.book, color: Colors.indigo),
                    title: Text('Chemistry Notes'),
                    subtitle: Text('3 hours • Completed'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable stat card widget
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 6, spreadRadius: 1),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
