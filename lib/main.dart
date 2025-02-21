// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/routes/routes.dart';
import 'package:test_app/pages/app_home/home_page.dart';
import 'package:test_app/pages/on_boarding/on_boarding_page.dart';
import 'package:test_app/pages/sign_in/sign_in_page.dart';
import 'package:test_app/pages/sign_up/sign_up_page.dart';
import 'package:test_app/pages/splash/splash_page.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: AppColors.lightBlueOne);
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: AppColors.darkBlueOne);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: CardTheme().copyWith(
          color: kDarkColorScheme.primaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: kDarkColorScheme.onPrimaryContainer)),
        floatingActionButtonTheme: FloatingActionButtonThemeData()
            .copyWith(backgroundColor: kDarkColorScheme.onPrimaryContainer),
        textTheme: TextTheme().copyWith(
          titleSmall: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: kDarkColorScheme.onPrimaryContainer),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        textSelectionTheme:
            TextSelectionThemeData(selectionColor: AppColors.greyOne),
        appBarTheme: AppBarTheme()
            .copyWith(backgroundColor: kColorScheme.primaryContainer),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.primaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData()
            .copyWith(backgroundColor: kColorScheme.primaryContainer),
        textTheme: ThemeData().textTheme.copyWith(
              titleSmall: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: kColorScheme.onPrimaryContainer),
            ),
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
