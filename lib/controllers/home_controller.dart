import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{
  bool isRightDoorLocked = true;
  bool isLeftDoorLocked = true;

  void updateRightDoorLock() {
    isRightDoorLocked = !isRightDoorLocked;
    notifyListeners();
  }
  void updateLeftDoorLock() {
    isRightDoorLocked = !isRightDoorLocked;
    notifyListeners();
  }
}
