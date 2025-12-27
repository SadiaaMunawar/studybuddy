import 'package:flutter/material.dart';

class Student {
  final String name;
  final String email;

  Student({required this.name, required this.email});
}

class StudyGroup {
  final String groupName;
  final List<Student> members;

  StudyGroup({required this.groupName, required this.members});
}

class StudyGroupsScreen extends StatefulWidget {
  const StudyGroupsScreen({super.key});

  @override
  State<StudyGroupsScreen> createState() => _StudyGroupsScreenState();
}

class _StudyGroupsScreenState extends State<StudyGroupsScreen> {
  final List<StudyGroup> _groups = [];

  void _createGroup() {
    final groupNameController = TextEditingController();
    final members = <Student>[];

    void _addMemberDialog() {
      final nameController = TextEditingController();
      final emailController = TextEditingController();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Add Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                  setState(() {
                    members.add(Student(
                      name: nameController.text,
                      email: emailController.text,
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

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Create Study Group'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: groupNameController,
                  decoration: const InputDecoration(labelText: 'Group Name'),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    _addMemberDialog();
                    setDialogState(() {}); // refresh dialog
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Add Member'),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120,
                  child: members.isEmpty
                      ? const Center(child: Text('No members yet'))
                      : ListView.builder(
                          itemCount: members.length,
                          itemBuilder: (context, index) {
                            final student = members[index];
                            return ListTile(
                              leading: const Icon(Icons.person, color: Colors.indigo),
                              title: Text(student.name),
                              subtitle: Text(student.email),
                            );
                          },
                        ),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  if (groupNameController.text.isNotEmpty && members.isNotEmpty) {
                    setState(() {
                      _groups.add(StudyGroup(
                        groupName: groupNameController.text,
                        members: List.from(members),
                      ));
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Study group created successfully!')),
                    );
                  }
                },
                child: const Text('Save Group'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Study Groups')),
      floatingActionButton: FloatingActionButton(
        onPressed: _createGroup,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.group_add),
      ),
      body: _groups.isEmpty
          ? const Center(child: Text('No study groups yet. Tap + to create one!'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _groups.length,
              itemBuilder: (context, index) {
                final group = _groups[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ExpansionTile(
                    leading: const Icon(Icons.group, color: Colors.indigo),
                    title: Text(group.groupName),
                    children: group.members
                        .map((student) => ListTile(
                              leading: const Icon(Icons.person, color: Colors.grey),
                              title: Text(student.name),
                              subtitle: Text(student.email),
                            ))
                        .toList(),
                  ),
                );
              },
            ),
    );
  }
}
