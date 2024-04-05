import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/constants/logo_text.dart';
import 'package:test_app/common/validators/validators.dart';
import 'package:test_app/common/widgets/custom_password_text_field.dart';
import 'package:test_app/common/widgets/custom_text_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteTwo,
      body: ListView(
        children: [
          LogoText(),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFormField(
                  labelText: 'Username',
                  hintText: 'kdim',
                  textCapitalization: TextCapitalization.words,
                  validator: Validator.validatorName,
                ),
                CustomPasswordField(
                  labelText: 'Password',
                  hintText: '*****',
                  helperText:
                      'Your password must contain at leat one number and a special charecter.',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 24.0),
                        child: ElevatedButton(
                          onPressed: () {
                            final valid = _formKey.currentState?.validate();
                            print(valid.toString());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightBlueTwo,
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                color: AppColors.whiteTwo,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
