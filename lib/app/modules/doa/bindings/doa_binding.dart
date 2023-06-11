import 'package:get/get.dart';

import '../controllers/doa_controller.dart';

class DoaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoaController>(
      () => DoaController(),
    );
  }
}
