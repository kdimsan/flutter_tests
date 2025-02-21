import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/routes/routes.dart';
import 'package:test_app/common/validators/validators.dart';
import 'package:test_app/common/widgets/custom_password_text_field.dart';
import 'package:test_app/common/widgets/custom_text_form_field.dart';
import 'package:test_app/common/constants/logo_text.dart';
import 'package:test_app/pages/sign_up/sign_up_controller.dart';
import 'package:test_app/pages/sign_up/sign_up_state.dart';
import 'package:test_app/services/secure_storage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _lastName = TextEditingController();

  final SignUpController _signUpController =
      SignUpController(const SecureStorage());

  @override
  void initState() {
    super.initState();
    _signUpController.addListener(() async {
      if (_signUpController.state is SignUpSuccessState) {
        navigateToSignIn();
      } else {
        print("Error Creating Account");
      }
    });
  }

  @override
  void dispose() {
    _signUpController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    _signUpController.doSignUp(_name.text, _lastName.text, _username.text,
        _email.text, _password.text);
  }

  void navigateToSignIn() {
    Navigator.pushReplacementNamed(context, MappedRoutes.signInPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: AppColors.gradientSplashBg,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogoText(),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              labelText: 'Name',
                              hintText: 'Maria',
                              textCapitalization: TextCapitalization.none,
                              validator: Validator.validatorName,
                              controller: _name,
                            ),
                          ),
                          Expanded(
                            child: CustomTextFormField(
                              labelText: 'Last Name',
                              hintText: 'Augusta',
                              textCapitalization: TextCapitalization.none,
                              validator: Validator.validatorName,
                              controller: _lastName,
                            ),
                          ),
                        ],
                      ),
                      CustomTextFormField(
                        labelText: 'Email',
                        hintText: 'email@email.com',
                        textCapitalization: TextCapitalization.none,
                        validator: Validator.validatorEmail,
                        controller: _email,
                      ),
                      CustomTextFormField(
                        labelText: 'Username',
                        hintText: 'kdim',
                        textCapitalization: TextCapitalization.none,
                        validator: Validator.validatorName,
                        controller: _username,
                      ),
                      CustomPasswordField(
                        labelText: 'Password',
                        hintText: '*****',
                        helperText:
                            'Your password must contain at least one number and a special charecter.',
                        controller: _password,
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
                                  final valid =
                                      _formKey.currentState?.validate();
                                  _create();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.whiteOne,
                                ),
                                child: Text(
                                  'Create account',
                                  style: TextStyle(
                                      color: AppColors.lightBlueTwo,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 24.0),
                  child: TextButton(
                      onPressed: () {
                        navigateToSignIn();
                      },
                      child: Text(
                        "Already have an account? Go to Sign In",
                        style: TextStyle(
                            color: AppColors.whiteTwo,
                            fontWeight: FontWeight.w800),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
