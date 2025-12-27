import 'package:flutter/material.dart';

class Resource {
  final String title;
  final String link;

  Resource({required this.title, required this.link});
}

class ResourceScreen extends StatefulWidget {
  const ResourceScreen({super.key});

  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  final _titleController = TextEditingController();
  final _linkController = TextEditingController();
  final List<Resource> _resources = [];

  void _addResource() {
    final title = _titleController.text.trim();
    final link = _linkController.text.trim();

    if (title.isNotEmpty && link.isNotEmpty) {
      setState(() {
        _resources.add(Resource(title: title, link: link));
      });
      _titleController.clear();
      _linkController.clear();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resources')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Resource Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _linkController,
              decoration: const InputDecoration(
                labelText: 'Resource Link / Reference',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Save button
            ElevatedButton.icon(
              onPressed: _addResource,
              icon: const Icon(Icons.save),
              label: const Text('Add Resource'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
              ),
            ),
            const SizedBox(height: 20),

            // Resource list
            Expanded(
              child: _resources.isEmpty
                  ? const Center(
                      child: Text(
                        'No resources yet. Add some!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _resources.length,
                      itemBuilder: (context, index) {
                        final resource = _resources[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.link, color: Colors.indigo),
                            title: Text(resource.title),
                            subtitle: Text(resource.link),
                            trailing: IconButton(
                              icon: const Icon(Icons.open_in_new, color: Colors.blue),
                              onPressed: () {
                                // Later: integrate url_launcher to open links
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Would open: ${resource.link}")),
                                );
                              },
                            ),
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
