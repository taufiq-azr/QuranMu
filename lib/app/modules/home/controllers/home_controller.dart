import 'dart:convert';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../../data/db/Bookmark.dart';
import '../../../data/models/Surah.dart';
import '../../../routes/app_pages.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../utils/globals.dart';

class HomeController extends GetxController {
  final DatabaseManager _database = DatabaseManager.instance;
  
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
      case 2:
        // Navigasi ke halaman Last
        Get.offAllNamed(Routes.LAST_READ);
        break;
      default:
        // Tindakan default jika indeks tidak sesuai
        break;
    }
  }

  Future<Map<String, dynamic>?> getLastRead() async {
    final db = await _database.db;
    List<Map<String, dynamic>?> data = await _database.db
        .then((db) => db.query("bookmark", where: "last_read = 1"));
    if (data.length == 0) {
      return null;
    } else {
      return data.first;
    }
  }

  Future<void> deleteLastRead(int id) async {
    final db = await _database.db;
    await db.delete("bookmark", where: "id = ?", whereArgs: [id]);
    update();
    Get.back();
    Get.snackbar("Berhasil", "Berhasil menghapus last read",
         colorText: HexColor("#FFFFFF"),
         backgroundColor: appbar);
  }
}
