import 'package:flutter/material.dart';

class StudyPlan {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<StudyTask> tasks;

  StudyPlan({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });
}

class StudyTask {
  final String subject;
  final int hours;

  StudyTask({required this.subject, required this.hours});
}

class StudyPlanScreen extends StatefulWidget {
  const StudyPlanScreen({super.key});

  @override
  State<StudyPlanScreen> createState() => _StudyPlanScreenState();
}

class _StudyPlanScreenState extends State<StudyPlanScreen> {
  final _titleController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  final List<StudyTask> _tasks = [];
  final List<StudyPlan> _plans = [];

  void _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _addTask() {
    final subjectController = TextEditingController();
    final hoursController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Study Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(labelText: 'Subject/Topic'),
            ),
            TextField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Hours'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (subjectController.text.isNotEmpty && hoursController.text.isNotEmpty) {
                setState(() {
                  _tasks.add(StudyTask(
                    subject: subjectController.text,
                    hours: int.tryParse(hoursController.text) ?? 0,
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _savePlan() {
    if (_titleController.text.isNotEmpty && _startDate != null && _endDate != null && _tasks.isNotEmpty) {
      setState(() {
        _plans.add(StudyPlan(
          title: _titleController.text,
          startDate: _startDate!,
          endDate: _endDate!,
          tasks: List.from(_tasks),
        ));
        _titleController.clear();
        _startDate = null;
        _endDate = null;
        _tasks.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Study Plan saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Study Plans')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Plan Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Plan Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Timeline
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _pickDate(true),
                    child: Text(_startDate == null
                        ? 'Pick Start Date'
                        : 'Start: ${_startDate!.toLocal().toString().split(' ')[0]}'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _pickDate(false),
                    child: Text(_endDate == null
                        ? 'Pick End Date'
                        : 'End: ${_endDate!.toLocal().toString().split(' ')[0]}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Tasks
            ElevatedButton.icon(
              onPressed: _addTask,
              icon: const Icon(Icons.add),
              label: const Text('Add Task'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(child: Text('No tasks added yet'))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.book, color: Colors.indigo),
                            title: Text(task.subject),
                            subtitle: Text('${task.hours} hours'),
                          ),
                        );
                      },
                    ),
            ),

            // Save Plan
            ElevatedButton(
              onPressed: _savePlan,
              child: const Text('Save Study Plan'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            const SizedBox(height: 12),

            // Saved Plans
            Expanded(
              child: _plans.isEmpty
                  ? const Center(child: Text('No study plans yet'))
                  : ListView.builder(
                      itemCount: _plans.length,
                      itemBuilder: (context, index) {
                        final plan = _plans[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.schedule, color: Colors.blue),
                            title: Text(plan.title),
                            subtitle: Text(
                                'From ${plan.startDate.toLocal().toString().split(' ')[0]} '
                                'to ${plan.endDate.toLocal().toString().split(' ')[0]} '
                                '(${plan.tasks.length} tasks)'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
