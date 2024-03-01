import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final EdgeInsets? padding;
  final int? maxLength;
  final String? hintText;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final Widget? suffixIcon;
  const CustomTextFormField(
      {super.key,
      required this.labelText,
      this.padding,
      this.maxLength,
      this.hintText,
      this.textCapitalization,
      this.textInputType,
      this.obscureText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText ?? false,
        keyboardType: textInputType ?? TextInputType.text,
        cursorColor: AppColors.greyOne,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        style: TextStyle(color: AppColors.lightBlueOne),
        maxLength: maxLength,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
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
