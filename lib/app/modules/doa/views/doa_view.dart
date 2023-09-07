import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quran/app/data/models/Doa.dart';

import '../../../routes/app_pages.dart';
import '../../utils/globals.dart';
import '../../utils/widget_reuse/appbarWidget.dart';
import '../../utils/widget_reuse/bottom_navigator.dart';
import '../controllers/doa_controller.dart';

class DoaView extends GetView<DoaController> {
  const DoaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  Text('Daftar Doa',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.sp,
                          color: const Color(0xFF121931))),
                ],
              ),
              SizedBox(height: 5.h),
              FutureBuilder<List<Doa>>(
                future: controller.getAllDoa(),
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
                            Doa doa = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_DOA, arguments: doa);
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
                                    "${doa.id}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: HexColor("FFFFFF"),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                              title: Text(
                                "${doa.doa}",
                                style: TextStyle(
                                    color: const Color(0xFF121931),
                                    fontSize: 15.sp,
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
