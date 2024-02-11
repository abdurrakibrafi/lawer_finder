// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/views/login/login-view.dart';
import 'package:lawer_finder/widgets/text.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userEmail;

  @override
  void initState() {
    super.initState();

    Map arguments = Get.arguments ?? {};
    userEmail = arguments['email'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.higlightColor,
        centerTitle: true,
        title: PText(
          text: AppConstant.myProfile,
          fontSize: 24.0,
        ),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16.0),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  userEmail!,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Edit Profile'),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.snackbar(
                          'Success',
                          'Logout successfully Done',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        Get.offAll(() => LoginPage());
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
