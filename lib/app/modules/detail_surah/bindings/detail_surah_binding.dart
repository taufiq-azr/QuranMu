import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSurahController>(
      () => DetailSurahController(),
    );
  }
}
