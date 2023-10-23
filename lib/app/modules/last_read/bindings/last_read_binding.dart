import 'package:get/get.dart';

import '../controllers/last_read_controller.dart';

class LastReadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LastReadController>(
      () => LastReadController(),
    );
  }
}
