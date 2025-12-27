class WordEntry {
  final String word;
  final String phonetic;
  final List<String> meanings;
  final List<String> synonyms;
  final List<String> antonyms;
  final bool favorite;

  WordEntry({
    required this.word,
    required this.phonetic,
    required this.meanings,
    required this.synonyms,
    required this.antonyms,
    this.favorite = false,
  });

  WordEntry copyWith({bool? favorite}) =>
      WordEntry(
        word: word,
        phonetic: phonetic,
        meanings: meanings,
        synonyms: synonyms,
        antonyms: antonyms,
        favorite: favorite ?? this.favorite,
      );
}
