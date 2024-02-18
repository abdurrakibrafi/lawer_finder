import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/utils/size/size.dart';
import 'package:lawer_finder/widgets/button.dart';
import 'package:lawer_finder/widgets/text-field.dart';
import 'package:lawer_finder/widgets/text.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: AppTheme.higlightColor,
        centerTitle: true,
        title: PText(
          text: AppConstant.editProfile,
          fontSize: 24.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: nameC,
              hint: "Enter Name",
              icon: Icons.person,
              keyboarType: TextInputType.text,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: emailC,
              hint: "Enter Email",
              icon: Icons.email,
              keyboarType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: phoneC,
              hint: "Enter Phone",
              icon: Icons.phone,
              keyboarType: TextInputType.phone,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: passC,
              hint: "Password",
              icon: Icons.phone,
              keyboarType: TextInputType.text,
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              width: sSize().width,
              height: 40.0,
              onTap: () {
                Get.snackbar(
                  'Wait',
                  'Up Coming',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              },
              widget: PText(
                text: "Update Profile",
                color: AppTheme.whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
