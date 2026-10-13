import 'package:get/get.dart';

class HomeNavController extends GetxController {
  int selectedIndex = 0;
  final Set<int> activatedIndexes = {0};
  void changeIndex(int index) {
    if (selectedIndex == index) return;

    selectedIndex = index;
    activatedIndexes.add(index);
    update();
  }

  bool isActivated(int index) => activatedIndexes.contains(index);

  void refreshIndex() {
    update();
  }
}
