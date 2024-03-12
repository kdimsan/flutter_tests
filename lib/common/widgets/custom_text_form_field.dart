import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final EdgeInsets? padding;
  final int? maxLength;
  final String? hintText;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final String? helperText;

  const CustomTextFormField(
      {super.key,
      required this.labelText,
      this.padding,
      this.maxLength,
      this.hintText,
      this.textCapitalization,
      this.textInputType,
      this.obscureText,
      this.suffixIcon,
      this.validator,
      this.helperText});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String? _textHelper;
  @override
  void initState() {
    super.initState();
    _textHelper = widget.helperText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: TextFormField(
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              _textHelper = null;
            });
          } else {
            setState(() {
              _textHelper = widget.helperText;
            });
          }
        },
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.obscureText ?? false,
        keyboardType: widget.textInputType ?? TextInputType.text,
        cursorColor: AppColors.greyOne,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        style: TextStyle(color: AppColors.lightBlueOne),
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          helperText: _textHelper,
          helperMaxLines: 3,
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle: TextStyle(color: AppColors.greyOne),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightBlueOne),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightBlueOne),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
