import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../data/models/Bookmark.dart';
import '../../../routes/app_pages.dart';
import '../../utils/globals.dart';
import '../../utils/widget_reuse/appbarWidget.dart';
import '../../utils/widget_reuse/bottom_navigator.dart';
import '../controllers/last_read_controller.dart';

class LastReadView extends StatelessWidget {
  final LastReadController controller = Get.put(LastReadController());

  LastReadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subBackgroundColor,
      appBar: appBar,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Daftar Bookmark',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      color: const Color(0xFF121931),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: Obx(
                  () => controller.getFilteredBookmarks().isEmpty
                      ? const Center(
                          child: Text(
                            "Tidak ada bookmark",
                            style: TextStyle(
                              color: Color(0xFF121931),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.getFilteredBookmarks().length,
                          itemBuilder: (context, index) {
                            Bookmark bookmark =
                                controller.getFilteredBookmarks()[index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                                  "name": bookmark.surah
                                      .toString()
                                      .replaceAll("*", "'"),
                                  "number": bookmark.number_surah,
                                  "index_ayat": bookmark.indexAyat,
                                });
                              },
                              leading: Container(
                                height: 60.h,
                                width: 40.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "lib/assets/svgs/nomor-surah.png",
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: HexColor("FFFFFF"),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "${bookmark.surah.toString().replaceAll("*", "'")}",
                                style: TextStyle(
                                  color: const Color(0xFF121931),
                                  fontSize: 15.sp,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              subtitle: Text(
                                "Ayat ${bookmark.ayat}",
                                style: TextStyle(
                                  color: const Color(0xFF121931),
                                  fontSize: 12.sp,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () => Get.defaultDialog(
                                    title: "Delete Bookmark",
                                    middleText:
                                        "Apakah kamu yakin ingin menghapus Bookmark ini ?",
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () => Get.back(),
                                          child: Text("Cancel")),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller
                                              .deleteBookmark(bookmark.id ?? 0);
                                        },
                                        child: Text("Delete"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors
                                              .red, // Mengatur warna latar belakang tombol
                                          onPrimary: Colors
                                              .white, // Mengatur warna teks
                                        ),
                                      ),
                                    ]),
                                icon: Icon(Icons.delete),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(
        controller.selectedIndex,
        controller.onItemTapped,
      ),
    );
  }
}
