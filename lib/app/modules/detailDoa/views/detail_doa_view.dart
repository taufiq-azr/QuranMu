import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quran/app/data/models/Doa.dart';
import 'package:quran/app/modules/utils/widget_reuse/appbarWidget.dart';

import '../../utils/globals.dart';
import '../controllers/detail_doa_controller.dart';

class DetailDoaView extends GetView<DetailDoaController> {
  DetailDoaView({Key? key}) : super(key: key);
  final Doa doa = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar,
        elevation: 0,
        title: Text(
          '${doa.doa}',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: subBackgroundColor,
              fontFamily: 'Poppins'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              '${doa.ayat}',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF121931),
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
                  color: const Color(0xFF121931),
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
                  color: const Color(0xFF121931),
                  fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
