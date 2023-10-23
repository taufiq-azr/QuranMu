import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quran/app/modules/utils/globals.dart';
import '../../../data/db/Bookmark.dart';
import '../../../data/models/Bookmark.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

class LastReadController extends GetxController {
  final DatabaseManager _database = DatabaseManager.instance;
  
  RxList<Bookmark> bookmarkList = <Bookmark>[].obs;
  int selectedIndex = 2;

  @override
  void onInit() {
    super.onInit();
    initBookmark();
  }

  Future<void> initBookmark() async {
    List<Map<String, dynamic>> data =
        await _database.db.then((db) => db.query("bookmark"));
    bookmarkList.assignAll(data.map((e) => Bookmark.fromJson(e)).toList());
  }


  Future<void> deleteBookmark(int id) async {
    final db = await _database.db;
    await db.delete("bookmark", where: "id = ?", whereArgs: [id]);
    await initBookmark();
    Get.back();
    Get.snackbar("Berhasil", "Berhasil menghapus bookmark",
        colorText: HexColor("#FFFFFF"),
         backgroundColor: appbar);
  }


  List<Bookmark> getFilteredBookmarks() {
    return bookmarkList.where((bookmark) => bookmark.lastRead == 0).toList();
  }

  void printBookmarkList() {
  print(bookmarkList);
}


  void onItemTapped(int index) {
    if (index >= 0 && index <= 2) {
      selectedIndex = index;
      update();
      switch (index) {
        case 0:
          Get.offAllNamed(Routes.HOME);
          break;
        case 1:
          Get.offAllNamed(Routes.DOA);
          break;
        case 2:
          Get.offAllNamed(Routes.LAST_READ);
          break;
        default:
          break;
      }
    }
  }
}
