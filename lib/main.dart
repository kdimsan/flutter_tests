// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/pages/sign_up/sing_up_page.dart';

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
      home: SignUpPage(),
    );
  }
}
