import 'dart:convert';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:quran/app/data/db/Bookmark.dart';
import 'package:quran/app/data/models/SurahDetail.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/globals.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();
  AutoScrollController scrollController = AutoScrollController();
  DatabaseManager database = DatabaseManager.instance;

  Future<void> addBookmark(
      bool lastRead, SurahDetail surah, Verse ayat, int index_ayat) async {
    Database db = await database.db;
    bool flagExist = false;

    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          columns: [
            "surah",
            "number_surah",
            "ayat",
            "via",
            "index_ayat",
            "last_read"
          ],
          where:
              "surah = '${surah.name!.transliteration!.id!.replaceAll("'", "*")}'and number_surah=${surah.number!} and ayat = ${ayat.number!.inSurah} and via = 'surah' and index_ayat = $index_ayat and last_read = 0");
      if (checkData.length != 0) {
        flagExist = true;
      }
    }

    if (flagExist != true) {
      await db.insert("bookmark", {
        "surah": "${surah.name!.transliteration!.id!.replaceAll("'", "*")}",
        "number_surah": surah.number!,
        "ayat": ayat.number!.inSurah,
        "via": "surah",
        "index_ayat": index_ayat,
        "last_read": lastRead == true ? 1 : 0,
      });

      Get.back();
      Get.snackbar("Berhasil", "Berhasil menambahkan bookmark",
          colorText: HexColor("#FFFFFF"),
         backgroundColor: appbar);
    } else {
      Get.back();
      Get.snackbar("Terjadi Kesalahan", "Bookmark Telah tersedia",
          colorText: HexColor("#FFFFFF"),
         backgroundColor: appbar);
    }

    var data = await db.query("bookmark");
    print(data);
  }

  Future<SurahDetail> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return SurahDetail.fromJson(data);
  }

  Verse? lastVerse;
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

  @override
  void onClose() {
    player.stop();
    player.dispose();
    Get.arguments?.clear();
    print(Get.arguments);
    scrollController.dispose();
    super.onClose();
  }

  void stopAudio(Verse ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "An error occured: $e");
    }
  }

  void resumeAudio(Verse ayat) async {
    try {
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "An error occured: $e");
    }
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "An error occured: $e");
    }
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      try {
        if (lastVerse == null) {
          lastVerse = ayat;
        }
        lastVerse!.kondisiAudio = "stop";
        lastVerse = ayat;
        lastVerse!.kondisiAudio = "stop";
        update();
        await player.stop();
        await player.setUrl(ayat!.audio!.primary);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Error message: ${e.message}");
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Connection aborted: ${e.message}");
      } catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan", middleText: "An error occured: $e");
      }
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "URL Audio tidak ada !");
    }

    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      } else {
        print('An error occurred: $e');
      }
    });
  }
}
