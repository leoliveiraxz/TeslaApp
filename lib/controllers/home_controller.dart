import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{
  bool isRightDoorLocked = true;
  bool isLeftDoorLocked = true;
  bool isBonnetLocked = true;
  bool isTrunkLocked = true;


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
