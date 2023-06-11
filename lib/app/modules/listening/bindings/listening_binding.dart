import 'package:get/get.dart';

import '../controllers/listening_controller.dart';

class ListeningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListeningController>(
      () => ListeningController(),
    );
  }
}
