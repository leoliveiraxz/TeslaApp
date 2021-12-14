// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla/constraints.dart';
import 'package:tesla/controllers/home_controller.dart';

import 'componentes/door_lock.dart';

class HomeScreen extends StatelessWidget {
  final homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: homeController,
        builder: (context, snapshot) {
          return Scaffold(body:
              SafeArea(child: LayoutBuilder(builder: (context, constraits) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: constraits.maxHeight * 0.1),
                    child: SvgPicture.asset("assets/icons/Car.svg",
                        width:
                            double.infinity //MediaQuery.of(context).size.width
                        )),
                Positioned(
                    right: constraits.maxWidth * 0.05,
                    child: DoorLock(
                        isLock: homeController.isRightDoorLocked,
                        press: homeController.updateRightDoorLock)),
                Positioned(
                    left: constraits.maxWidth * 0.05,
                    child: DoorLock(
                        isLock: homeController.isRightDoorLocked,
                        press: homeController.updateRightDoorLock))
              ],
            );
          })));
        });
  }
}