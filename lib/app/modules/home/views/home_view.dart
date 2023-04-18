import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran/app/routes/app_pages.dart';
import '../../../data/models/Surah.dart';
import '../../utils/globals.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: text,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(children: [
          const SizedBox(
            width: 24,
          ),
          Text(
            'Qur\'anKu',
            style: 
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: background),
               
              
                
          ),
        ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                'Assalamualaikum ..',
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: text),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                'Selamat Datang !',
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: text),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
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
                          Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                        },
                        leading: Container(
                          height: 60,
                          width: 40,
                          decoration: const BoxDecoration(
                        
                
                            image: DecorationImage(

                                image: AssetImage("lib/assets/svgs/nomor-surah.png")),
                          ),
                          child: Center(
                            child: Text(
                              "${surah.number}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: text, fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          "${surah.name!.transliteration?.id} | ${surah.name?.translation?.id}",
                          style: const TextStyle(
                              color: Color(0xFF121931), fontSize: 15),
                        ),
                        subtitle: Text(
                          "${surah.numberOfVerses ?? 0} | ${surah.revelation?.id ?? ""}",
                          style: const TextStyle(color: Color(0xFF121931), ),
                        ),
                        trailing: Text(
                          surah.name!.short ?? "",
                          style: const TextStyle(color: Color(0xFF121931), fontWeight: FontWeight.bold),
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
    );
  }
}
