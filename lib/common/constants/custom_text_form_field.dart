import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final EdgeInsets? padding;
  final int? maxLength;
  final String? hintText;
  const CustomTextFormField(
      {super.key,
      required this.labelText,
      this.padding,
      this.maxLength,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: TextFormField(
        cursorColor: AppColors.greyOne,
        textCapitalization: TextCapitalization.words,
        style: TextStyle(color: AppColors.lightBlueOne),
        maxLength: maxLength,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(color: AppColors.greyOne),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightBlueOne),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightBlueOne),
          ),
        ),
      ),
    );
  }
}
