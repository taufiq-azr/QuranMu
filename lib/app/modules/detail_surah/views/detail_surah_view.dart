import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quran/app/data/models/Surah.dart';
import 'package:quran/app/data/models/SurahDetail.dart' as detail;
import 'package:quran/app/routes/app_pages.dart';

import '../../utils/globals.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: text,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(children: [
          IconButton(
            onPressed: (() => {
                  Get.offNamed(Routes.HOME),
                }),
            icon: Icon(Icons.arrow_back_ios, color: HexColor("#a19cc5")),
          ),
          const SizedBox(
            width: 24,
          ),
          Text(
            'Surah ${surah.name?.transliteration?.id}',
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.bold, color: background),
          ),
        ]),
      ),
      body: ListView(
        children: [
          Card(
            color: background,
            elevation: 0,
            child: Column(children: [
              Text(
                '${surah.name?.transliteration?.id}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '( ${surah.name?.translation?.id} ) ',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${surah.numberOfVerses} Ayat | ${surah.revelation?.id}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
          const SizedBox(
            height: 10,
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
                    height: MediaQuery.of(context).size.width <
                            MediaQuery.of(context).size.height
                        ? MediaQuery.of(context).size.height * 0.75
                        : MediaQuery.of(context).size.height * 0.8,
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
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
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Text(
                                '${ayat?.text?.arab}',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Text(
                                '${ayat?.text?.transliteration?.en}',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 15, bottom: 15),
                              child: Text(
                                '${ayat?.translation?.id}',
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
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
