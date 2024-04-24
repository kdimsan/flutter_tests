import 'package:flutter/material.dart';
import 'package:test_app/common/widgets/custom_text_form_field.dart';

class CustomPasswordField extends StatefulWidget {
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
  final TextEditingController? controller;

  const CustomPasswordField(
      {super.key,
      required this.labelText,
      this.padding,
      this.maxLength,
      this.hintText,
      this.textInputType,
      this.textCapitalization,
      this.obscureText,
      this.suffixIcon,
      this.validator,
      this.helperText,
      this.controller});

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      helperText: widget.helperText,
      hintText: widget.hintText,
      labelText: widget.labelText,
      obscureText: isHidden,
      validator: widget.validator,
      suffixIcon: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {
          setState(() {
            isHidden = !isHidden;
          });
        },
        child: isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
      ),
    );
  }
}
