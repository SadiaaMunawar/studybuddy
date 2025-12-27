import 'package:flutter/material.dart';
import '../models/task.dart';

class ProgressChart extends StatelessWidget {
  final List<Task> tasks;
  const ProgressChart({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completed = tasks.where((t) => t.completed).length;
    final pending = tasks.length - completed;
    final percent = tasks.isEmpty ? 0 : (completed / tasks.length * 100).round();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('Weekly Performance: $percent%', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: tasks.isEmpty ? 0 : completed / tasks.length),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Completed: $completed'),
              Text('Pending: $pending'),
            ],
          ),
        ],
      ),
    );
  }
}
