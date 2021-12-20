// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla/constraints.dart';
import 'package:tesla/controllers/home_controller.dart';

import 'componentes/battery_status.dart';
import 'componentes/door_lock.dart';
import 'componentes/tesla_botton_navigationBar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final homeController = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  void setupBatteryAnimation() {
    _batteryAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animationBattery = CurvedAnimation(
        parent: _batteryAnimationController, curve: Interval(0.0, 0.5));
    _animationBatteryStatus = CurvedAnimation(
        parent: _batteryAnimationController, curve: Interval(0.6, 1.0));
  }

  @override
  void initState() {
    setupBatteryAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation:
            Listenable.merge([homeController, _batteryAnimationController]),
        builder: (context, snapshot) {
          return Scaffold(
              bottomNavigationBar: TeslaBottomNavigationBar(
                onTap: (index) {
                  if (index == 1)
                    _batteryAnimationController.forward();
                  else if (homeController.selectedBottomTab == 1 && index != 1)
                    _batteryAnimationController.reverse();
                  homeController.onBottomNavigationTabChange(index);
                },
                selectedTab: homeController.selectedBottomTab,
              ),
              body:
                  SafeArea(child: LayoutBuilder(builder: (context, constraits) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constraits.maxHeight * 0.1),
                        child: SvgPicture.asset("assets/icons/Car.svg",
                            width: double
                                .infinity //MediaQuery.of(context).size.width
                            )),
                    AnimatedPositioned(
                        duration: defaultDuration,
                        right: homeController.selectedBottomTab == 0
                            ? constraits.maxWidth * 0.05
                            : constraits.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity:
                              homeController.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                              isLock: homeController.isRightDoorLocked,
                              press: homeController.updateRightDoorLock),
                        )),
                    AnimatedPositioned(
                        duration: defaultDuration,
                        left: homeController.selectedBottomTab == 0
                            ? constraits.maxWidth * 0.05
                            : constraits.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity:
                              homeController.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                              isLock: homeController.isLeftDoorLocked,
                              press: homeController.updateLeftDoorLock),
                        )),
                    AnimatedPositioned(
                        duration: defaultDuration,
                        top: homeController.selectedBottomTab == 0
                            ? constraits.maxHeight * 0.05
                            : constraits.maxHeight / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity:
                              homeController.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                              isLock: homeController.isBonnetLocked,
                              press: homeController.updateBonnetDoorLock),
                        )),
                    AnimatedPositioned(
                        duration: defaultDuration,
                        bottom: homeController.selectedBottomTab == 0
                            ? constraits.maxHeight * 0.05
                            : constraits.maxHeight / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity:
                              homeController.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                              isLock: homeController.isTrunkLocked,
                              press: homeController.updateTrunkDoorLock),
                        )),
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        "assets/icons/Battery.svg",
                        width: constraits.maxWidth * 0.45,
                      ),
                    ),
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      height: constraits.maxHeight,
                      width: constraits.maxWidth,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(
                          constraits: constraits,
                        ),
                      ),
                    )
                  ],
                );
              })));
        });
  }
}
