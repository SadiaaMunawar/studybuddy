import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/word.dart';

class DictionaryService {
  // Example: https://api.dictionaryapi.dev/api/v2/entries/en/<word>
  static Future<WordEntry?> fetchWord(String word) async {
    final url = Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');
    final res = await http.get(url);
    if (res.statusCode != 200) return null;

    final data = jsonDecode(res.body);
    if (data is! List || data.isEmpty) return null;

    final entry = data.first;
    final phonetic = entry['phonetic'] ?? '';
    final meanings = <String>[];
    final synonyms = <String>[];
    final antonyms = <String>[];

    for (final m in entry['meanings'] ?? []) {
      for (final d in m['definitions'] ?? []) {
        if (d['definition'] != null) meanings.add(d['definition']);
        if (d['synonyms'] != null) synonyms.addAll(List<String>.from(d['synonyms']));
        if (d['antonyms'] != null) antonyms.addAll(List<String>.from(d['antonyms']));
      }
    }

    return WordEntry(
      word: word,
      phonetic: phonetic,
      meanings: meanings,
      synonyms: synonyms.toSet().toList(),
      antonyms: antonyms.toSet().toList(),
    );
  }
}
