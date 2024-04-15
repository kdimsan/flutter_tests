import 'package:flutter/foundation.dart';
import 'package:test_app/pages/sign_up/sign_up_state.dart';

class SignUpController extends ChangeNotifier {
  SignUpState state = SignUpInitialState();

  void updateState(SignUpState newState) {
    state = newState;
  }

  Future<bool> doSignUp() async {
    await Future.delayed(Duration(seconds: 2));
    print("Usuário logado");
    return true;
  }
}
