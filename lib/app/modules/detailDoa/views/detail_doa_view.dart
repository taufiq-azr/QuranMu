import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/app/data/models/Doa.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/globals.dart';
import '../controllers/detail_doa_controller.dart';

class DetailDoaView extends GetView<DetailDoaController> {
  DetailDoaView({Key? key}) : super(key: key);
  final Doa doa = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("186351"),
      appBar: AppBar(
        backgroundColor: appbar,
        elevation: 0,
        title: Row(children: [
          Text(
            'Qur\'anKu',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: subBackgroundColor,
                fontFamily: 'Poppins'),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Text(
                  '${doa.doa}',
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: subBackgroundColor,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 200.w,
                  height: 200.h,
                  child: Lottie.asset(
                    'lib/assets/pray.json',
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: HexColor("fffffff"),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  '${doa.ayat}',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: HexColor("ffffff"),
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  '${doa.latin}',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: HexColor("ffffff"),
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  '${doa.artinya}',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: HexColor("ffffff"),
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
