import 'package:get/get.dart';

import '../controllers/detail_doa_controller.dart';

class DetailDoaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailDoaController>(
      () => DetailDoaController(),
    );
  }
}
