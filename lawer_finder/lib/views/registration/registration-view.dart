import 'package:flutter/material.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/services/firebase_auth_services.dart';
import 'package:lawer_finder/utils/size/size.dart';
import 'package:lawer_finder/utils/toast_msg.dart';
import 'package:lawer_finder/views/login/login-view.dart';
import 'package:lawer_finder/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import '../../app/routes.dart';
import '../../widgets/text-field.dart';

import '../../widgets/text.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PText(
              text: "Sign Up",
              fontSize: 24,
              color: AppTheme.whiteColor,
            ),
            box(10),
            PText(
              text: "Sign Up to discover amazing things",
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
                    Get.offNamed(AppRoute.loginRoute);
                  },
                  child: RichText(
                      text: const TextSpan(
                          style: TextStyle(
                              color: AppTheme.blackColor, fontSize: 16),
                          text: "Already Have an Account Yet? ",
                          children: [
                        TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                                color: AppTheme.higlightColor, fontSize: 20.0))
                      ])),
                ))
          ],
        ),
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
  final FirebaseAuthService _auth = FirebaseAuthService();

  bool isSigningUp = false;

  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppTheme.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          CustomTextField(
            controller: nameC,
            hint: "Name",
            icon: Icons.person,
            keyboarType: TextInputType.text,
          ),
          box(20),
          CustomTextField(
            controller: emailC,
            hint: "Email",
            icon: Icons.email,
            keyboarType: TextInputType.emailAddress,
          ),
          box(20),
          CustomTextField(
            controller: phoneC,
            hint: "Phone No",
            icon: Icons.phone,
            keyboarType: TextInputType.number,
          ),
          box(20),
          CustomTextField(
            controller: passC,
            hint: "Password must be 6 digit",
            icon: Icons.password,
            keyboarType: TextInputType.text,
          ),
          box(30.0),
          CustomButton(
            width: sSize().width,
            height: 40.0,
            onTap: () {
              if (nameC.text.isEmpty ||
                  phoneC.text.isEmpty ||
                  passC.text.isEmpty ||
                  emailC.text.isEmpty) {
                Get.snackbar(
                  'Alert',
                  'All Filed Are Required,Fill up Please.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              } else {
                _signUp();
              }
            },
            widget: PText(
              text: "Sign Up",
              color: AppTheme.whiteColor,
            ),
          )
        ],
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = nameC.text;
    String email = emailC.text;
    String password = passC.text;
    String phone = phoneC.text;

    User? user = await _auth.signUpWithEmailAndPassword(
        email, password, username, phone);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      // Show a success snackbar
      Get.snackbar(
        'Success',
        'User Sign Up submitted successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
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
