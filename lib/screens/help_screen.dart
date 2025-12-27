import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Need Assistance?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Here you can find answers to common questions and ways to reach support.',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 20),

          // FAQ Section
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          ExpansionTile(
            leading: const Icon(Icons.help_outline, color: Colors.indigo),
            title: const Text('How do I add a new task?'),
            children: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Go to the Dashboard and tap the "+" button at the bottom right to add a new task.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.help_outline, color: Colors.indigo),
            title: const Text('Can I edit or delete a flashcard?'),
            children: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Yes, open the Flashcards screen, tap on a card, and choose edit or delete.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.help_outline, color: Colors.indigo),
            title: const Text('How do I reset my password?'),
            children: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Go to Settings > Account > Reset Password. Follow the instructions provided.',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Contact Support
          const Text(
            'Contact Support',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.email, color: Colors.indigo),
              title: const Text('support@studybuddy.com'),
              subtitle: const Text('Email us for assistance'),
              onTap: () {
                // Later: integrate email launcher
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.phone, color: Colors.indigo),
              title: const Text('+92 300 1234567'),
              subtitle: const Text('Call us for urgent help'),
              onTap: () {
                // Later: integrate phone dialer
              },
            ),
          ),

          const SizedBox(height: 20),

          // Tips Section
          const Text(
            'Quick Tips',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const ListTile(
            leading: Icon(Icons.lightbulb, color: Colors.orange),
            title: Text('Use the Focus Timer to stay productive.'),
          ),
          const ListTile(
            leading: Icon(Icons.lightbulb, color: Colors.orange),
            title: Text('Organize your study plans for better tracking.'),
          ),
          const ListTile(
            leading: Icon(Icons.lightbulb, color: Colors.orange),
            title: Text('Check Analytics to see your progress.'),
          ),
        ],
      ),
    );
  }
}
