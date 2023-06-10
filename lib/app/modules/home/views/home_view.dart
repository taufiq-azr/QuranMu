import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:quran/app/routes/app_pages.dart';
import '../../../data/models/Surah.dart';
import '../../utils/globals.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: SubBackground,
      appBar: AppBar(
        backgroundColor: SubBackground,
        elevation: 0,
        title: Row(children: [
          Text(
            'Qur\'anKu',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: appbar_text,
                fontFamily: 'Poppins'),
          ),
        ]),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'lib/assets/logo_home.png',
              ),
              FutureBuilder<List<Surah>>(
                future: controller.getAllSurah(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
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
                              decoration: BoxDecoration(
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
                                  color: Color(0xFF121931),
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
    );
  }
}
