import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../globals.dart';

PreferredSizeWidget appBar = AppBar(
  backgroundColor: subBackgroundColor,
  elevation: 0,
  title: Row(children: [
    Text(
      'Qur\'anMu',
      style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: appbar,
          fontFamily: 'Poppins'),
    ),
  ]),
);
