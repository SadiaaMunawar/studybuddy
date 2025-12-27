import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool pushNotifications = true;
  bool emailDigest = false;
  bool autoSave = true;
  double focusDuration = 25;
  String breakDuration = '5 min';

  final List<String> breakOptions = ['5 min', '10 min', '15 min'];

  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = AuthService.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
    }
  }

  Future<void> _saveName() async {
    final newName = _nameController.text.trim();
    if (newName.isEmpty) return;

    await AuthService.updateDisplayName(newName);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Name updated successfully")),
    );
    setState(() {}); // refresh UI
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final user = AuthService.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Profile Settings
          const Text("Profile Settings", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Full Name'),
                  subtitle: Text(user?.displayName ?? 'No name'),
                ),
                ListTile(
                  title: const Text('Email'),
                  subtitle: Text(user?.email ?? 'No email'),
                ),
                ListTile(title: const Text('Role'), subtitle: const Text('Student')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Edit Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _saveName,
            icon: const Icon(Icons.save),
            label: const Text("Save Name"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
          ),

          const SizedBox(height: 24),

          // Notifications
          const Text("Notifications", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text('Push Notifications'),
            value: pushNotifications,
            onChanged: (val) => setState(() => pushNotifications = val),
          ),
          SwitchListTile(
            title: const Text('Email Digest'),
            value: emailDigest,
            onChanged: (val) => setState(() => emailDigest = val),
          ),

          const SizedBox(height: 24),

          // Appearance (Theme Mode only)
          const Text("Appearance", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              title: const Text('Theme Mode'),
              trailing: DropdownButton<ThemeMode>(
                value: theme.mode,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                  DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                  DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                ],
                onChanged: (v) => theme.setMode(v!),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Focus Timer
          const Text("Focus Timer", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text('Focus Duration: ${focusDuration.round()} min'),
                  subtitle: Slider(
                    value: focusDuration,
                    min: 15,
                    max: 60,
                    divisions: 9,
                    label: '${focusDuration.round()} min',
                    onChanged: (val) => setState(() => focusDuration = val),
                  ),
                ),
                ListTile(
                  title: const Text('Break Duration'),
                  trailing: DropdownButton<String>(
                    value: breakDuration,
                    items: breakOptions.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                    onChanged: (val) => setState(() => breakDuration = val!),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Data & Privacy
          const Text("Data & Privacy", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text('Auto-save'),
            value: autoSave,
            onChanged: (val) => setState(() => autoSave = val),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Exporting data...")),
                    );
                  },
                  icon: const Icon(Icons.download),
                  label: const Text("Export All Data"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Data cleared")),
                    );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Clear All Data"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Save/Cancel buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Settings saved")),
                    );
                  },
                  child: const Text("Save Changes"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
