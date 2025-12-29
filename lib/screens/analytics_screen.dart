import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No tasks found"));
          }

          final tasks = snapshot.data!.docs;

          // Count completed and pending tasks
          final completedTasks =
              tasks.where((t) => (t.data() as Map<String, dynamic>)['status'] == 'completed').length;
          final pendingTasks =
              tasks.where((t) => (t.data() as Map<String, dynamic>)['status'] == 'pending').length;

          // Sum study hours safely
          final studyHours = tasks.fold<int>(
            0,
            (sum, t) {
              final data = t.data() as Map<String, dynamic>;
              final duration = data['duration'];
              if (duration is int) {
                return sum + duration;
              } else if (duration is String) {
                return sum + (int.tryParse(duration) ?? 0);
              } else {
                return sum;
              }
            },
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Study Analytics',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Quick stats cards (no chart)
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

                const Text(
                  'Recent Activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: ListView(
                    children: tasks.map((t) {
                      final data = t.data() as Map<String, dynamic>;
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.book, color: Colors.indigo),
                          title: Text(data['title'] ?? 'Untitled'),
                          subtitle: Text(
                            '${data['duration'] ?? 0} hours • ${data['status'] ?? 'unknown'}',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
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
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 1,
            ),
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
