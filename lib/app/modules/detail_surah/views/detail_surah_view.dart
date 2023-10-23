import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:quran/app/data/models/SurahDetail.dart' as detail;
import 'package:quran/app/modules/home/controllers/home_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../utils/globals.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);
  final HomeC = Get.put(HomeController());
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
            'Surah ${Get.arguments["name"]}',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: subBackgroundColor,
                fontFamily: 'Poppins'),
          ),
        ]),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: controller
              .getDetailSurah(Get.arguments["number"].toString()
              ),
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
              detail.SurahDetail surah = snapshot.data!;
              if (Get.arguments != null &&
                  Get.arguments.containsKey("index_ayat")) {
                controller.scrollController.scrollToIndex(
                  Get.arguments["index_ayat"],
                  preferPosition: AutoScrollPosition.begin,
                );
              }

              return ListView(children: [
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
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    height: 480.h,
                    child: ListView.builder(
                      
                        shrinkWrap: true,
                        controller: controller.scrollController,
                        itemCount: snapshot.data?.verses.length ?? 0,
                        itemBuilder: (context, index) {
                          // ignore: prefer_is_empty
                          if (snapshot.data?.verses.length == 0) {
                            return const SizedBox();
                          }
                          detail.Verse? ayat = snapshot.data?.verses[index];
                          return AutoScrollTag(
                            key: ValueKey(index),
                            index: index,
                            controller: controller.scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Card(
                                    elevation: 0,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
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
                                          GetBuilder<DetailSurahController>(
                                              builder: (c) => Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            print(Get
                                                                .arguments);
                                                            Get.defaultDialog(
                                                              title: "BOOKMARK",
                                                              middleText:
                                                                  "Pilih jenis bookmark",
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await c.addBookmark(
                                                                        true,
                                                                        snapshot
                                                                            .data!,
                                                                        ayat!,
                                                                        index);
                                                                    HomeC
                                                                        .update();
                                                                  },
                                                                  child: Text(
                                                                      "Last Read"),
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    primary:
                                                                        appbar,
                                                                  ),
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    c.addBookmark(
                                                                        false,
                                                                        snapshot
                                                                            .data!,
                                                                        ayat!,
                                                                        index);
                                                                  },
                                                                  child: Text(
                                                                      "Bookmark"),
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    primary:
                                                                        appbar,
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                          icon: Icon(Icons
                                                              .bookmark_add_outlined)),
                                                      (ayat?.kondisiAudio ==
                                                              "stop")
                                                          ? IconButton(
                                                              onPressed: () {
                                                                c.playAudio(
                                                                    ayat);
                                                              },
                                                              icon: Icon(Icons
                                                                  .play_arrow_outlined),
                                                            )
                                                          : Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                  (ayat?.kondisiAudio ==
                                                                          "playing")
                                                                      ? IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            c.pauseAudio(ayat!);
                                                                          },
                                                                          icon:
                                                                              Icon(Icons.pause_outlined),
                                                                        )
                                                                      : IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            c.resumeAudio(ayat!);
                                                                          },
                                                                          icon:
                                                                              Icon(Icons.play_arrow_outlined),
                                                                        ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      c.stopAudio(
                                                                          ayat!);
                                                                    },
                                                                    icon: Icon(Icons
                                                                        .stop_outlined),
                                                                  )
                                                                ])
                                                    ],
                                                  ))
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(right: 15, left: 15)
                                          .r,
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
                                      const EdgeInsets.only(right: 15, left: 15)
                                          .r,
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
                                        margin: EdgeInsets.symmetric(
                                                horizontal: 5.0)
                                            .r,
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
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                                    right: 15,
                                                    left: 15,
                                                    bottom: 15)
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
                            ),
                          );
                        }))
              ]);
            }
          },
        ),
      ),
    );
  }
}
