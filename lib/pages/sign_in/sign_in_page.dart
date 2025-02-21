import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/constants/logo_text.dart';
import 'package:test_app/common/routes/routes.dart';
import 'package:test_app/common/validators/validators.dart';
import 'package:test_app/common/widgets/custom_password_text_field.dart';
import 'package:test_app/common/widgets/custom_text_form_field.dart';
import 'package:test_app/pages/sign_in/sign_in_controller.dart';
import 'package:test_app/pages/sign_in/sign_in_state.dart';
import 'package:test_app/services/secure_storage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  final _secureStorage = SecureStorage();

  final SignInController _signInController =
      SignInController(const SecureStorage());

  Future<void> _login() async {
    _signInController.loginFunction(_username.text, _password.text);
  }

  @override
  void initState() {
    super.initState();
    _signInController.addListener(() async {
      if (_signInController.state is SignInSuccessState) {
        print(await _secureStorage.readOne(key: 'user_access_token'));
        navigateToApp();
      } else {
        print(
            "error ${await _secureStorage.readOne(key: 'user_access_token')}");
      }
    });
  }

  @override
  void dispose() {
    _signInController.dispose();
    super.dispose();
  }

  void navigateToApp() {
    Navigator.pushReplacementNamed(context, MappedRoutes.appPage);
  }

  void navigateToSignUp() {
    Navigator.pushReplacementNamed(context, MappedRoutes.signUpPage);
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
                                final valid = _formKey.currentState?.validate();
                                _login();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.whiteOne,
                              ),
                              child: Text(
                                'Sign In',
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
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                child: TextButton(
                  onPressed: () {
                    navigateToSignUp();
                  },
                  child: Text(
                    "Don't have account? Go to Sign Up",
                    style: TextStyle(
                        color: AppColors.whiteTwo, fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
