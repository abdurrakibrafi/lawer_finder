import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              onTap: () {},
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

  void _updateProfile() async {
    String newName = nameC.text;
    String newEmail = emailC.text;
    String newPhone = phoneC.text;
    String newPassword = passC.text;

    try {
      // Get the current user from Firebase Authentication
      User? currentUser = FirebaseAuth.instance.currentUser;

      // Update user's profile information in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .update({
        'username': newName,
        'email': newEmail,
        'phoneNumber': newPhone,
      });

      await currentUser?.updateDisplayName(newName);

      if (currentUser?.email != newEmail) {
        await currentUser?.updateEmail(newEmail);
        await currentUser?.sendEmailVerification();

        await FirebaseAuth.instance.signOut();

        Get.snackbar(
          'Success',
          'Profile Updated successfully. Please verify the new email before logging in again.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        if (newPassword.isNotEmpty) {
          await currentUser?.updatePassword(newPassword);
        }

        // Show a success snackbar
        Get.snackbar(
          'Success',
          'Profile Updated successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      print('Error updating profile: $error');

      Get.snackbar(
        'Error',
        'Failed to update profile. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
