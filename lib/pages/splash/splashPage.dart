import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/constants/app_text_styles.dart';
import 'package:test_app/common/constants/logo_text.dart';
import 'package:test_app/common/routes/routes.dart';
import 'package:test_app/pages/on_boarding/on_boarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Timer init() {
    return Timer(Duration(seconds: 2), navigateToNext);
  }

  void navigateToNext() {
    Navigator.pushReplacementNamed(
      context,
      MappedRoutes.onBoardingPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
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
            Text("Build your World."),
            CircularProgressIndicator(
              color: AppColors.whiteOne,
            ),
          ],
        ),
      ),
    );
  }
}
