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
  const CustomPasswordField(
      {super.key,
      required this.labelText,
      this.padding,
      this.maxLength,
      this.hintText,
      this.textInputType,
      this.textCapitalization,
      this.obscureText,
      this.suffixIcon});

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      labelText: widget.labelText,
      hintText: widget.hintText,
      obscureText: isHidden,
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
