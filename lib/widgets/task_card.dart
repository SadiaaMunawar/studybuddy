import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../app_router.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.read<TaskProvider>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text('Due: ${task.dueDate}'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'edit') {
              Navigator.pushNamed(context, AppRouter.taskEditor, arguments: task);
            } else if (value == 'delete') {
              await taskProvider.deleteTask(task);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task deleted')),
              );
            } else if (value == 'reschedule') {
              // Example: open date picker
              final newDate = await showDatePicker(
                context: context,
                initialDate: task.dueDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (newDate != null) {
                final updated = task.copyWith(dueDate: newDate);
                await taskProvider.updateTask(updated);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task rescheduled')),
                );
              }
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
            const PopupMenuItem(value: 'reschedule', child: Text('Reschedule')),
          ],
        ),
      ),
    );
  }
}
