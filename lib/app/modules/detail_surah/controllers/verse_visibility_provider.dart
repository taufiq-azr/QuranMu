import 'package:get/get.dart';

class VerseVisibilityProvider extends GetxController {
  RxList<bool> isTafsirVisibleList = <bool>[].obs;

  void initVisibilityList(int length) {
    isTafsirVisibleList.value = List<bool>.filled(length, false);
  }

  void toggleVisibility(int index) {
    if (index >= 0 && index < isTafsirVisibleList.length) {
      isTafsirVisibleList[index] = !isTafsirVisibleList[index];
      isTafsirVisibleList.refresh(); // Refresh list untuk memperbarui tampilan
    }
  }

  bool isVisible(int index) {
    if (index >= 0 && index < isTafsirVisibleList.length) {
      return isTafsirVisibleList[index];
    }
    return false;
  }
}
