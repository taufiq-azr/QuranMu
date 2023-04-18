import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran/app/data/models/SurahDetail.dart';

void main() async {
  // Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  //   var res = await http.get(url);

  //   List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

  //   print(data);

  Future<SurahDetail> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return SurahDetail.fromJson(data);
  }

  await getDetailSurah(1.toString());
}
