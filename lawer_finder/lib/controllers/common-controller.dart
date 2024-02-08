import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawer_finder/app/routes.dart';
import 'package:lawer_finder/views/home/home-view.dart';
import 'package:lawer_finder/views/lawer%20list%20screen/lawer_list_screen.dart';
import 'package:lawer_finder/views/profile/profile_screen.dart';

class CommonController extends GetxController {
  //bottom-nav
  List page = [const HomeView(), LawerListScreen(), ProfileScreen()];
  var selectePageIndex = 0.obs;

  //bottom-action
  void chanageBottomPageIndex(int seletedPage) {
    selectePageIndex.value = seletedPage;
    debugPrint(selectePageIndex.value.toString());
  }

  //change splash to others :login/nav
  void changeSplashView() async {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(AppRoute.loginRoute);
    });
  }
}
