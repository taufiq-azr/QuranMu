import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/app/modules/home/views/home_view.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationController extends GetxController {
  var selectedPage = 0.obs;

  void changePage(int index) {
    selectedPage.value = index;
  }
}

class BottomNavigationApp extends StatelessWidget {
  final bottomNavigationController = Get.put(BottomNavigationController());

   BottomNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => _bottomNavigationBar()),
      body: SafeArea(
        child: IndexedStack(
          index: bottomNavigationController.selectedPage.value,
          children: [
            HomeView(),
             Container(height: 300),
            //PrayerPage(),
            //DoaPage(),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: bottomNavigationController.selectedPage.value,
        onTap: bottomNavigationController.changePage,
        items: [
          _bottomBarItem(
              icon: "lib/assets/svgs/quran-icon.svg", label: "Quran"),
          _bottomBarItem(
              icon: "lib/assets/svgs/pray-icon.svg", label: "Prayer"),
          _bottomBarItem(icon: "lib/assets/svgs/doa-icon.svg", label: "Doa"),
        ],
      );

  BottomNavigationBarItem _bottomBarItem(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          icon,
          color: Colors.black,
        ),
        activeIcon: SvgPicture.asset(
          icon,
          color: Colors.blue,
        ),
        label: label,
      );
}
