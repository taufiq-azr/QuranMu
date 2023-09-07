import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/Surah.dart';
import '../../../routes/app_pages.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeController extends GetxController {
  Future<List<Surah>> getAllSurah() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // Tidak ada koneksi internet, tampilkan pesan peringatan di sini.
      print("Tidak ada koneksi internet");
      return [];
    }

    Uri url = Uri.parse("https://api.quran.gading.dev/surah");
    var res = await http.get(url);

    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }

  int selectedIndex = 0;
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
      default:
        // Tindakan default jika indeks tidak sesuai
        break;
    }
  }
}
