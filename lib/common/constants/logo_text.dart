import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/constants/app_text_styles.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'World Points',
      style: AppTextStyles.logoText.copyWith(color: AppColors.whiteOne),
    );
  }
}
