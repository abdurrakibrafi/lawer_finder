import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawer_finder/app/routes.dart';
import 'package:lawer_finder/views/home/home-view.dart';

class CommonController extends GetxController {
  //bottom-nav
  List page = [const HomeView(), Container(), Container(), Container()];
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
