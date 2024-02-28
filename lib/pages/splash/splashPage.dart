import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/constants/app_text_styles.dart';
import 'package:test_app/common/constants/logo_text.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.gradientSplashBg,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LogoText(),
            CircularProgressIndicator(
              color: AppColors.whiteOne,
            ),
            Text(
              'Splash Page',
              style: AppTextStyles.bigText50w700
                  .copyWith(color: AppColors.whiteOne),
            ),
          ],
        ),
      ),
    );
  }
}
