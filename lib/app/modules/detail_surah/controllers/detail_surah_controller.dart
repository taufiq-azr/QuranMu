import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quran/app/data/models/SurahDetail.dart';

class DetailSurahController extends GetxController {
  Future<SurahDetail> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return SurahDetail.fromJson(data);
   
  }
}
