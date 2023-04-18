import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/globals.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      // Get.offNamed(Routes.HOME);
    });

    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) => Transform.translate(
                  offset: Offset(0, controller.animation.value),
                  child: child,
                ),
                child: Image.asset(
                  'lib/assets/logo_splash.png',
                  height: 500,
                  width: 500,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    'Qur\'anKu',
                    style: GoogleFonts.poppins(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: text),
                  ),
                ],
              ),
            ),
            Text(
              'By Taufiq Al Azhar',
              style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontStyle: FontStyle.italic, fontWeight:FontWeight.bold,
                  color: text),
            ),
          ],
        ),
      ),
    );
  }
}
