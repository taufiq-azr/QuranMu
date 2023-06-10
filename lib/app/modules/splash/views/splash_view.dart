import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../routes/app_pages.dart';
import '../../utils/globals.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(Routes.HOME);
    });

    return Scaffold(
      backgroundColor: MainBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/logo_splash.png',
              height: 391.h,
              width: 341.w,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Qur\'anKu',
              style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: logo_text,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(height: 20.sp),
            Text(
              'Bacalah meskipun hanya ',
              style: TextStyle(
                  fontSize: 24.sp,
                  color: HexColor("FFFFFF"),
                  fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.sp),
            Text(
              'satu ayat',
              style: TextStyle(
                fontSize: 24.sp,
                color: HexColor("FFFFFF"),
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            CircularProgressIndicator(
              color: HexColor("FFFFFF"),
            ),
          ],
        ),
      ),
    );
  }
}
