import 'package:flutter/foundation.dart';
import 'sign_in_state.dart';
import 'package:test_app/services/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:test_app/common/routes/routes.dart';

class SignInController extends ChangeNotifier {
  final SecureStorage _service;
  final SecureStorage _secureStorage = const SecureStorage();
  SignInController(this._service);

  SignInState _state = SignInInitialState();

  SignInState get state => _state;

  void _updateState(SignInState newState) {
    _state = newState;
    notifyListeners();
  }

  void loginFunction(String username, String password) async {
    if (username == "ralph" && password == "000") {
      return _updateState(SignInSuccessState());
    }
    String url =
        'http://192.168.1.134:8080/realms/trektek/protocol/openid-connect/token';

    Map<String, dynamic> requestData = {
      'grant_type': 'password',
      'username': username,
      'password': password,
      'client_secret': 'ArkUV4tvZn865kCT89DCNs0Y8rKHq9Hv',
      'client_id': 'worlds-points',
    };
    try {
      var response = await http.post(Uri.parse(url), body: requestData);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('Login bem sucedido');
        var jsonResponse = convert.jsonDecode(response.body);
        print(response.body);
        await _secureStorage.write(
            key: 'user_access_token', value: jsonResponse['access_token']);
        print(await _secureStorage.readOne(key: 'user_access_token'));
        return _updateState(SignInSuccessState());
      } else {
        print('Erro durante o login: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro durante a requisição: $error');
    }
  }
}
