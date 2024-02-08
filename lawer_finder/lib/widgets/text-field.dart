import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lawer_finder/app/theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.keyboarType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType keyboarType;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      decoration: BoxDecoration(
        color: AppTheme.higlightColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      controller: controller, // Assign the controller directly
      prefix: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Icon(icon),
      ),
      placeholder: hint,
      placeholderStyle: const TextStyle(color: AppTheme.blackColor),
      keyboardType: keyboarType, // Use the provided keyboardType
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    );
  }
}

