import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:test_app/pages/sign_up/sign_up_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:test_app/services/secure_storage.dart';

class SignUpController extends ChangeNotifier {
  final SecureStorage _service;
  final SecureStorage _secureStorage = const SecureStorage();
  SignUpController(this._service);

  SignUpState _state = SignUpInitialState();

  SignUpState get state => _state;

  void _updateState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  void doSignUp(name, lastName, userName, email, password) async {
    String url = "http://192.168.1.134:8080/admin/realms/trektek/users";
    String? appToken = await _secureStorage.readOne(key: "app_access_token");
    String headerToken = 'Bearer $appToken';

    Map<String, dynamic> requestBodyData = {
      "firstName": name,
      "lastName": lastName,
      "email": email,
      "enabled": true,
      "username": userName,
      "credentials": [
        {"type": "password", "value": password, "temporary": false}
      ]
    };
    String jsonBody = json.encode(requestBodyData);
    Map<String, String> requestHeader = {
      "Authorization": headerToken,
      "Content-Type": "application/json"
    };
    try {
      var response = await http.post(Uri.parse(url),
          headers: requestHeader, body: jsonBody);
      print(response.statusCode);
      if (response.statusCode == 201) {
        _updateState(SignUpSuccessState());
      }
    } catch (error) {
      print('Erro durante a requisição: $error');
    }
  }
}
