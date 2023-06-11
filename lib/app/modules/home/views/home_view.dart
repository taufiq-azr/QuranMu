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
              Image.asset(
                'lib/assets/logo_home.png',
              ),
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Failed to load data: ${snapshot.error}"),
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
                              Get.toNamed(Routes.DETAIL_SURAH,
                                  arguments: surah);
                            },
                            leading: Container(
                              height: 60.h,
                              width: 40.w,
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
