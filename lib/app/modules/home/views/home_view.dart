import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:quran/app/routes/app_pages.dart';
import '../../../data/models/Surah.dart';
import '../../utils/globals.dart';
import '../../utils/widget_reuse/appbarWidget.dart';
import '../../utils/widget_reuse/bottom_navigator.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: subBackgroundColor,
      appBar: appBar,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(15.0).w,
                  child: GetBuilder<HomeController>(
                    builder: (c) => FutureBuilder<Map<String, dynamic>?>(
                      future: c.getLastRead(),
                      builder: (context, snapshot) {
                        Map<String, dynamic>? lastRead = snapshot.data;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            gradient: LinearGradient(
                              colors: [
                                HexColor("87d1a4"),
                                HexColor("006754"),
                              ],
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onLongPress: () {
                                if (lastRead != null) {
                                  Get.defaultDialog(
                                      title: "Delete Last Read",
                                      middleText:
                                          "Apakah kamu yakin ingin menghapus Last Read Bookmark ini ?",
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () => Get.back(),
                                            child: Text("Cancel")),
                                        ElevatedButton(
                                          onPressed: () {
                                            c.deleteLastRead(lastRead['id']);
                                          },
                                          child: Text("Delete"),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .red, // Mengatur warna latar belakang tombol
                                            onPrimary: Colors
                                                .white, // Mengatur warna teks
                                          ),
                                        ),
                                      ]);
                                }
                              },
                              onTap: () {
                                if (lastRead != null) {
                                  print(lastRead);
                                     Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                                    "name": lastRead["surah"]
                                        .toString()
                                        .replaceAll("*", "'"),
                                    "number": lastRead["number_surah"],
                                    "index_ayat": lastRead["index_ayat"],
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(15).w,
                                height: 150.h,
                                width: Get.width.w,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: -60,
                                      right: -50,
                                      child: Opacity(
                                        opacity: 0.7,
                                        child: SizedBox(
                                          width: 200.w,
                                          height: 200.h,
                                          child: Image.asset(
                                            "lib/assets/svgs/quran_logos.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.menu_book_rounded,
                                              color: HexColor("#004B40"),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              "Terakhir dibaca",
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                color: HexColor("#004B40"),
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        if (lastRead != null)
                                          Text(
                                            "${lastRead['surah'].replaceAll("*", "'")}",
                                            style: TextStyle(
                                              color: HexColor("#004B40"),
                                              fontSize: 20.sp,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        Text(
                                          lastRead == null
                                              ? "Belum ada data"
                                              : "Ayat ${lastRead['ayat']}",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            color: HexColor("#004B40"),
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20.w),
                  Text('Daftar Surah',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.sp,
                          color: const Color(0xFF121931))),
                ],
              ),
              SizedBox(height: 5.h),
              FutureBuilder<List<Surah>>(
                future: controller.getAllSurah(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: 140.h),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Failed to load data: ${snapshot.error}"),
                    );
                  } else {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          "Tidak ada koneksi internet",
                          style: TextStyle(
                              color: const Color(0xFF121931),
                              fontSize: 15.sp,
                              fontFamily: 'Poppins'),
                        ),
                      );
                    } else {
                      // Menampilkan daftar surah jika data berhasil diambil
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Surah surah = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                                  "name": surah.name!.transliteration!.id,
                                  "number": surah.number,
                                });
                              },
                              leading: Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "lib/assets/svgs/nomor-surah.png")),
                                ),
                                child: Center(
                                  child: Text(
                                    "${surah.number}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: HexColor("FFFFFF"),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                              title: Text(
                                "${surah.name!.transliteration?.id}",
                                style: TextStyle(
                                    color: const Color(0xFF121931),
                                    fontSize: 15.sp,
                                    fontFamily: 'Poppins'),
                              ),
                              subtitle: Text(
                                "${surah.numberOfVerses ?? 0} | ${surah.revelation?.id ?? ""}",
                                style: TextStyle(
                                    color: HexColor("858585"),
                                    fontFamily: 'Poppins'),
                              ),
                              trailing: Text(
                                surah.name!.short ?? "",
                                style: TextStyle(
                                    color: HexColor("076C58"),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          buildBottomNavigationBar(controller.selectedIndex, (index) {
        controller.onItemTapped(index);
      }),
    );
  }
}
