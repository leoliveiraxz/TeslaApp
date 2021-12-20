import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  int selectedBottomTab = 0;

  bool isRightDoorLocked = true;
  bool isLeftDoorLocked = true;
  bool isBonnetLocked = true;
  bool isTrunkLocked = true;

  void onBottomNavigationTabChange(int index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  void updateRightDoorLock() {
    isRightDoorLocked = !isRightDoorLocked;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLocked = !isLeftDoorLocked;
    notifyListeners();
  }

  void updateBonnetDoorLock() {
    isBonnetLocked = !isBonnetLocked;
    notifyListeners();
  }

  void updateTrunkDoorLock() {
    isTrunkLocked = !isTrunkLocked;
    notifyListeners();
  }
}
