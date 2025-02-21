import 'package:flutter/foundation.dart';
import 'splash_state.dart';
import 'package:test_app/services/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SplashController extends ChangeNotifier {
  final SecureStorage _service;
  final SecureStorage _secureStorage = const SecureStorage();
  SplashController(this._service);

  SplashState _state = SplashInitialState();

  SplashState get state => _state;

  void _updateState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }

  void getAppAccessToken() async {
    String url =
        'http://192.168.1.134:8080/realms/trektek/protocol/openid-connect/token';

    Map<String, dynamic> requestData = {
      'grant_type': 'client_credentials',
      'client_secret': 'ArkUV4tvZn865kCT89DCNs0Y8rKHq9Hv',
      'client_id': 'worlds-points',
    };
    await _secureStorage.deleteOne(key: 'app_access_token');
    try {
      var response = await http.post(Uri.parse(url), body: requestData);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        await _secureStorage.write(
            key: 'app_access_token', value: jsonResponse['access_token']);
        print(await _secureStorage.readAll());
      }
    } catch (error) {
      print('Erro durante a requisição: $error');
    }
  }

  void isUserLogged() async {
    final result = await _service.readOne(key: "user_access_token");
    if (result != null) {
      _updateState(SplashSuccessState());
    } else {
      _updateState(SplashErrorState());
    }
  }
}
