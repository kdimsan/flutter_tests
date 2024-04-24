import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/constants/logo_text.dart';
import 'package:test_app/common/routes/routes.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  void _goToSignIn() {
    Navigator.pushReplacementNamed(context, MappedRoutes.signInPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueOne,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30.0),
                child: LogoText(),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Have you ever wished a place where you can... World Places is the place where you can do it all!",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Create account",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlueTwo),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  TextButton(
                    onPressed: _goToSignIn,
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteOne),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
