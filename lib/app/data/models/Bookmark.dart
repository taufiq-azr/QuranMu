class Bookmark {
  int? id;
  String? surah;
  int? number_surah;
  int? ayat;
  String? via;
  int? indexAyat;
  int? lastRead;

  Bookmark({
    this.id,
    this.surah,
    this.number_surah,
    this.ayat,
    this.via,
    this.indexAyat,
    this.lastRead,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'] as int?,
      surah: json['surah'] as String?,
      number_surah: json['number_surah'] as int?,
      ayat: json['ayat'] as int?,
      via: json['via'] as String?,
      indexAyat: json['index_ayat'] as int?,
      lastRead: json['last_read'] as int?,
    );
  }
  //Check List Item in Bookmark model
  String toString() {
    return 'Bookmark{id: $id, surah: $surah, number_surah: $number_surah, ayat: $ayat, via: $via, indexAyat: $indexAyat, lastRead: $lastRead}';
  }
}
