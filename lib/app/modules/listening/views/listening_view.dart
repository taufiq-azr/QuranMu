import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran/app/modules/utils/globals.dart';

import '../../utils/widget_reuse/appbarWidget.dart';
import '../../utils/widget_reuse/bottom_navigator.dart';
import '../controllers/listening_controller.dart';

class ListeningView extends GetView<ListeningController> {
  const ListeningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subBackgroundColor,
      appBar: appBar,
      body: const Center(
        child: Text(
          'ListeningView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar:
          buildBottomNavigationBar(controller.selectedIndex, (index) {
        controller.onItemTapped(index);
      }),
    );
  }
}
