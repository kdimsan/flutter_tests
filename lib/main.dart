// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/routes/routes.dart';
import 'package:test_app/homePage.widget.dart';
import 'package:test_app/pages/on_boarding/on_boarding_page.dart';
import 'package:test_app/pages/sign_in/sign_in_page.dart';
import 'package:test_app/pages/sign_up/sign_up_page.dart';
import 'package:test_app/pages/splash/splashPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme:
            TextSelectionThemeData(selectionColor: AppColors.greyOne),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Autentication',
      initialRoute: MappedRoutes.initialPage,
      routes: {
        MappedRoutes.initialPage: (context) => const SplashPage(),
        MappedRoutes.onBoardingPage: (context) => const OnBoardingPage(),
        MappedRoutes.signUpPage: (context) => const SignUpPage(),
        MappedRoutes.signInPage: (context) => const SignInPage(),
        MappedRoutes.appPage: (context) => const HomePage(),
      },
    );
  }
}
