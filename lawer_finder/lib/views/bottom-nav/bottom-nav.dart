import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/controllers/common-controller.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class BottomNaviApp extends GetView<CommonController> {
  const BottomNaviApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () {
            return controller.page[controller.selectePageIndex.value];
          },
        ),
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Obx(
            () {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: FlashyTabBar(
                  height: 55,
                  selectedIndex: controller.selectePageIndex.value,
                  showElevation: false,
                  backgroundColor: AppTheme.higlightColor,
                  onItemSelected: controller.chanageBottomPageIndex,
                  items: [
                    FlashyTabBarItem(
                      icon: const Icon(Icons.event),
                      title: const Text('Home'),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(Icons.people),
                      title: const Text('Lawer'),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(Icons.person),
                      title: const Text('Profile'),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
