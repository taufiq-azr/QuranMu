import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    animation = Tween<double>(
      begin: -10,
      end: 20,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceInOut,
        //  reverseCurve: Curves.bounceIn
      ),
    );

    animationController.forward().whenComplete(() {
      Get.offNamed(Routes.HOME);
    });
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
