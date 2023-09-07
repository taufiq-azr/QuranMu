import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:quran/app/data/models/Surah.dart';
import 'package:quran/app/data/models/SurahDetail.dart' as detail;
import '../../utils/globals.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);
  final Surah surah = Get.arguments;
  @override
  final DetailSurahController controller = Get.put(DetailSurahController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar,
        elevation: 0,
        title: Row(children: [
          Text(
            'Surah ${surah.name?.transliteration?.id}',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: subBackgroundColor,
                fontFamily: 'Poppins'),
          ),
        ]),
      ),
      body: ListView(
        children: [
          Card(
            color: subBackgroundColor,
            elevation: 0,
            child: Column(children: [
              Text(
                '${surah.name?.transliteration?.id}',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '( ${surah.name?.translation?.id} ) ',
                style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                '${surah.numberOfVerses} Ayat | ${surah.revelation?.id}',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 20.h,
              ),
            ]),
          ),
          SizedBox(
            height: 10.h,
          ),
          FutureBuilder<detail.SurahDetail>(
              future: controller.getDetailSurah(surah.number.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Failed to load data: ${snapshot.error}"),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Tidak Ada Data !"),
                  );
                } else {
                  return SizedBox(
                    height: 480.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.verses.length ?? 0,
                      itemBuilder: (context, index) {
                        // ignore: prefer_is_empty
                        if (snapshot.data?.verses.length == 0) {
                          return const SizedBox();
                        }
                        detail.Verse? ayat = snapshot.data?.verses[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              elevation: 0,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5.r,
                                  horizontal: 10.r,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "lib/assets/svgs/nomor-surah.png")),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15).r,
                              child: Text(
                                '${ayat?.text?.arab}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    color: HexColor("004B40"),
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15).r,
                              child: Text(
                                '${ayat?.text?.transliteration?.en}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontStyle: FontStyle.italic,
                                    color: HexColor("004B40"),
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                      right: 15, left: 15, bottom: 15)
                                  .r,
                              child: Text(
                                '${ayat?.translation?.id}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: HexColor("076C58"),
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            SizedBox(
                              height: 20.5.h,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.toggleContainer(index);
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0).r,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(12.0).r,
                                    decoration: BoxDecoration(
                                      color: appbar,
                                      borderRadius:
                                          BorderRadius.circular(8.0).r,
                                    ),
                                    child: Obx(() => Text(
                                          controller.isVisible(index)
                                              ? 'Tekan untuk Tutup Tafsir'
                                              : 'Tekan untuk Tampilkan Tafsir',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                                SizedBox(height: 16.0.h),
                                Obx(() {
                                  return Visibility(
                                    visible: controller.isVisible(index),
                                    child: Container(
                                      padding: EdgeInsets.all(12.0).r,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.green)),
                                        padding: const EdgeInsets.only(
                                                right: 15, left: 15, bottom: 15)
                                            .r,
                                        child: Text(
                                          '${ayat?.tafsir?.id.long}',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: HexColor("076C58"),
                                              fontFamily: 'Poppins'),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            )
                          ],
                        );
                      },
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
