import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class DoaController extends GetxController {
  //TODO: Implement DoaController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  int selectedIndex = 1;
  void onItemTapped(int index) {
    selectedIndex = index;
    // Lakukan tindakan tambahan berdasarkan indeks yang dipilih
    switch (index) {
      case 0:
        // Navigasi ke halaman Home
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        // Navigasi ke halaman Doa
        Get.offAllNamed(Routes.DOA);
        break;
      case 2:
        // Navigasi ke halaman Listening
        Get.offAllNamed(Routes.LISTENING);
        break;
      default:
        // Tindakan default jika indeks tidak sesuai
        break;
    }
  }
}
