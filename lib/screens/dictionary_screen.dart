import 'package:flutter/material.dart';
import '../services/dictionary_service.dart';
import '../services/local_storage_service.dart';
import '../models/word.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final _controller = TextEditingController();
  WordEntry? _entry;
  bool loading = false;

  Future<void> _search() async {
    setState(() => loading = true);
    final word = _controller.text.trim();
    final res = await DictionaryService.fetchWord(word);
    setState(() {
      _entry = res;
      loading = false;
    });
  }

  void _toggleFavorite() async {
    if (_entry == null) return;
    final fav = LocalStorageService.isFavorite(_entry!.word);
    await LocalStorageService.setFavoriteWord(_entry!.word, !fav);
    setState(() => _entry = _entry!.copyWith(favorite: !fav));
  }

  @override
  Widget build(BuildContext context) {
    final fav = _entry != null && LocalStorageService.isFavorite(_entry!.word);
    return Scaffold(
      appBar: AppBar(title: const Text('Dictionary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter word'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading ? null : _search,
              child: const Text('Search'),
            ),
            const SizedBox(height: 16),
            if (loading) const CircularProgressIndicator(),
            if (!loading && _entry != null)
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_entry!.word} • ${_entry!.phonetic}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: _toggleFavorite,
                          icon: Icon(
                              fav ? Icons.favorite : Icons.favorite_border),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Meanings',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    ..._entry!.meanings.map((m) => ListTile(title: Text(m))),
                    const SizedBox(height: 8),
                    const Text('Synonyms',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      children: _entry!.synonyms
                          .map((s) => Chip(label: Text(s)))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    const Text('Antonyms',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      children: _entry!.antonyms
                          .map((a) => Chip(label: Text(a)))
                          .toList(),
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
