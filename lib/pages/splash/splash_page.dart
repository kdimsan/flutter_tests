import 'package:flutter/material.dart';
import 'package:test_app/common/constants/app_colors.dart';
import 'package:test_app/common/constants/logo_text.dart';
import 'package:test_app/common/routes/routes.dart';
import 'package:test_app/pages/splash/splash_controller.dart';
import 'package:test_app/pages/splash/splash_state.dart';
import 'package:test_app/services/secure_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController _splashController =
      SplashController(const SecureStorage());
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    _splashController.getAppAccessToken();
    _splashController.isUserLogged();
    _splashController.addListener(() async {
      if (_splashController.state is SplashSuccessState) {
        print(await _secureStorage.readOne(key: 'user_access_token'));
        navigateToMainPage();
      } else {
        navigateToOnBoarding();
        print(await _secureStorage.readOne(key: 'user_access_token'));
      }
    });
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
  }

  void navigateToOnBoarding() {
    Navigator.pushReplacementNamed(
      context,
      MappedRoutes.onBoardingPage,
    );
  }

  void navigateToMainPage() {
    Navigator.pushReplacementNamed(
      context,
      MappedRoutes.appPage,
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
