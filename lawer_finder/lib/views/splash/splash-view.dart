import 'package:flutter/material.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/controllers/common-controller.dart';
import 'package:lawer_finder/utils/size/size.dart';
import 'package:lawer_finder/utils/theme/theme.dart';
import 'package:lawer_finder/widgets/text.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CommonController>().changeSplashView();
    return Scaffold(
      backgroundColor: themeData().primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/logo-lottie.json',
                height: sSize().height * 0.3,
                width: sSize().height * 0.3,
                fit: BoxFit.cover),
            PText(
              text: AppConstant.appName,
              fontSize: 30.0,
              color: AppTheme.higlightColor,
            )
          ],
        ),
      ),
    );
  }
}
