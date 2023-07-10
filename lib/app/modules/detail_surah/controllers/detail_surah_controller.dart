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

  RxInt visibleIndex = RxInt(-1);

  void toggleContainer(int index) {
    if (visibleIndex.value == index) {
      visibleIndex.value = -1;
    } else {
      visibleIndex.value = index;
    }
  }

  bool isVisible(int index) {
    return visibleIndex.value == index;
  }
}
