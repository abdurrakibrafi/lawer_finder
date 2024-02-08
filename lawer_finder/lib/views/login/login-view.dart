import 'package:flutter/material.dart';
import 'package:lawer_finder/app/routes.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/services/firebase_auth_services.dart';
import 'package:lawer_finder/utils/size/size.dart';
import 'package:lawer_finder/utils/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lawer_finder/utils/toast_msg.dart';
import 'package:lawer_finder/widgets/button.dart';

import 'package:get/get.dart';
import '../../widgets/text-field.dart';

import '../../widgets/text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

class TextFieldArea extends StatefulWidget {
  const TextFieldArea({
    super.key,
  });

  @override
  State<TextFieldArea> createState() => _TextFieldAreaState();
}

class _TextFieldAreaState extends State<TextFieldArea> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppTheme.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          CustomTextField(
            controller: _emailController,
            hint: "Enter Email",
            icon: Icons.email,
            keyboarType: TextInputType.number,
          ),
          box(20),
          CustomTextField(
            controller: _passwordController,
            hint: "Password must be 6 Digit",
            icon: Icons.password,
            keyboarType: TextInputType.text,
          ),
          box(30.0),
          CustomButton(
            width: sSize().width,
            height: 40.0,
            onTap: () {
              if (_emailController.text.isEmpty ||
                  _passwordController.text.isEmpty) {
                Get.snackbar(
                  'Alert',
                  'All Filed Are Required,Fill up Please.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              } else {
                _signIn();
              }
            },
            widget: PText(
              text: "Sign In",
              color: AppTheme.whiteColor,
            ),
          )
        ],
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      Get.snackbar(
        'Success',
        'User Sign in successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.toNamed(AppRoute.bottomNavRoute);
    } else {
      Get.snackbar(
        'Error',
        'Failed Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
