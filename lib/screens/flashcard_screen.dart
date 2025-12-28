import 'package:flutter/material.dart';

class Flashcard {
  final String question;
  final String answer;

  Flashcard({required this.question, required this.answer});
}

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  final List<Flashcard> _flashcards = [];

  void _addFlashcard() {
    final question = _questionController.text.trim();
    final answer = _answerController.text.trim();

    if (question.isNotEmpty && answer.isNotEmpty) {
      setState(() {
        _flashcards.add(Flashcard(question: question, answer: answer));
      });
      _questionController.clear();
      _answerController.clear();
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                labelText: 'Answer',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Save button (updated style)
            ElevatedButton.icon(
              onPressed: _addFlashcard,
              icon: const Icon(Icons.save, size: 20),
              label: const Text(
                'Save Flashcard',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // List of saved flashcards
            Expanded(
              child: _flashcards.isEmpty
                  ? const Center(
                      child: Text(
                        'No flashcards yet. Add some!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _flashcards.length,
                      itemBuilder: (context, index) {
                        final card = _flashcards[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.lightbulb, color: Colors.indigo),
                            title: Text(card.question),
                            subtitle: Text(card.answer),
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
