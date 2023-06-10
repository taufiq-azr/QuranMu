import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:quran/app/data/models/Surah.dart';

void main() {
  group('Surah Model Test', () {
    test('Parse Surah JSON', () {
      // Sample JSON data for Surah
      final jsonString = '''
        {
          "number": 1,
      "sequence": 5,
      "numberOfVerses": 7,
      "name": {
        "short": "الفاتحة",
        "long": "سُورَةُ ٱلْفَاتِحَةِ",
        "transliteration": {
          "en": "Al-Faatiha",
          "id": "Al-Fatihah"
        },
        "translation": {
          "en": "The Opening",
          "id": "Pembukaan"
        }
      },
      "revelation": {
        "arab": "مكة",
        "en": "Meccan",
        "id": "Makkiyyah"
      },
      "tafsir": {
        "id": "Surat Al Faatihah (Pembukaan) yang diturunkan di Mekah dan terdiri dari 7 ayat adalah surat yang pertama-tama diturunkan dengan lengkap  diantara surat-surat yang ada dalam Al Quran dan termasuk golongan surat Makkiyyah. Surat ini disebut Al Faatihah (Pembukaan), karena dengan surat inilah dibuka dan dimulainya Al Quran. Dinamakan Ummul Quran (induk Al Quran) atau Ummul Kitaab (induk Al Kitaab) karena dia merupakan induk dari semua isi Al Quran, dan karena itu diwajibkan membacanya pada tiap-tiap sembahyang. Dinamakan pula As Sab'ul matsaany (tujuh yang berulang-ulang) karena ayatnya tujuh dan dibaca berulang-ulang dalam sholat."
      }
        }
      ''';

      // Convert JSON to Surah object
      final surah = Surah.fromJson(json.decode(jsonString));


      expect(surah, isA<Surah>());
      expect(surah.number, isNotNull);
      expect(surah.sequence, isNotNull);
      expect(surah.numberOfVerses, isNotNull);
      expect(surah.name, isA<Name>());
      expect(surah.revelation, isA<Revelation>());
      expect(surah.tafsir, isA<Tafsir>());
      expect(surah.sequence, isNotNull);
    });
  });
}

Future<Surah> getSurahDetail(String id) async {
  Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
  var res = await http.get(url);

  if (res.statusCode == 200) {
    Map<String, dynamic> data = json.decode(res.body)["data"];
    return Surah.fromJson(data);
  } else {
    throw Exception('Failed to get surah detail');
  }
}
