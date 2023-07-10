import 'dart:convert';

import 'package:get/get.dart';
import 'package:quran/app/data/models/Doa.dart';
import 'package:http/http.dart' as http;
import '../../../routes/app_pages.dart';

class DoaController extends GetxController {
  Future<List<Doa>> getAllDoa() async {
    Uri url = Uri.parse("https://doa-doa-api-ahmadramadhan.fly.dev/api");
    var res = await http.get(url);

    List<dynamic> responseData = json.decode(res.body);
    if (responseData == null || responseData.isEmpty) {
      return [];
    } else {
      return responseData.map((e) => Doa.fromJson(e)).toList();
    }
  }

  int selectedIndex = 1;
  void onItemTapped(int index) {
    selectedIndex = index;
    // Lakukan tindakan tambahan berdasarkan indeks yang dipilih
    switch (index) {
      case 0:
        // Navigasi ke halaman Home
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        // Navigasi ke halaman Doa
        Get.offAllNamed(Routes.DOA);
        break;
      case 2:
        // Navigasi ke halaman Listening
        Get.offAllNamed(Routes.COMPASS);
        break;
      default:
        // Tindakan default jika indeks tidak sesuai
        break;
    }
  }
}
