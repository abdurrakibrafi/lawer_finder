import 'package:flutter/material.dart';
import 'package:lawer_finder/app/routes.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/utils/size/size.dart';
import 'package:lawer_finder/utils/theme/theme.dart';
import 'package:lawer_finder/widgets/button.dart';

import 'package:get/get.dart';
import '../../widgets/text-field.dart';

import '../../widgets/text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: sSize().height,
          width: sSize().width,
          child: Stack(
            children: [
              Container(
                height: sSize().height / 2.2,
                decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
              //input taken : loign and password
              const InfoArea()
            ],
          ),
        ),
      ),
    );
  }
}

class InfoArea extends StatelessWidget {
  const InfoArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: sSize().height * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PText(
            text: "Sign In",
            fontSize: 24,
            color: AppTheme.whiteColor,
          ),
          box(10),
          PText(
            text: "Sign in to discover amazing things",
            fontSize: 12,
            color: AppTheme.whiteColor,
          ),
          box(70),

          //textfield
          const TextFieldArea(),

          box(40),
          Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.registrationRoute);
                },
                child: RichText(
                    text: const TextSpan(
                        style:
                            TextStyle(color: AppTheme.blackColor, fontSize: 16),
                        text: "Not Have an Account Yet? ",
                        children: [
                      TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                              color: AppTheme.higlightColor, fontSize: 20.0))
                    ])),
              )),
        ],
      ),
    );
  }
}

class TextFieldArea extends StatelessWidget {
  const TextFieldArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppTheme.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          CustomTextField(
            controller: TextEditingController(),
            hint: "Email",
            icon: Icons.email,
            keyboarType: TextInputType.number,
          ),
          box(20),
          CustomTextField(
            controller: TextEditingController(),
            hint: "Password",
            icon: Icons.password,
            keyboarType: TextInputType.number,
          ),
          box(30.0),
          CustomButton(
            width: sSize().width,
            height: 40.0,
            onTap: () {
              Get.toNamed(AppRoute.bottomNavRoute);
            },
            widget: PText(
              text: "Sign In",
              color: AppTheme.whiteColor,
            ),
          )
          // : Center(
          //     child: CircularProgressIndicator(
          //       color: themeData().primaryColor,
          //     ),
          //   )
        ],
      ),
    );
  }
}
