class VumiHelpers {
  // Membersihkan angka chapter untuk kebutuhan UI
  static String formatChapter(String rawChapter) {
    return rawChapter.replaceAll(RegExp(r'[^0-9.]'), '');
  }

  // Mengubah slug komik menjadi judul yang lebih rapi (Capitalize)
  static String slugToTitle(String slug) {
    return slug
        .split('-')
        .map((word) {
          if (word.isEmpty) return "";
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}
