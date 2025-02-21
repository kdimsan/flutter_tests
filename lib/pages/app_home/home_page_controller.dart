import 'package:flutter/foundation.dart';
import 'home_page_state.dart';
import 'package:test_app/services/secure_storage.dart';

class HomePageController extends ChangeNotifier {
  final SecureStorage _service;
  HomePageController(this._service);

  HomePageState _state = HomePageInitialState();

  HomePageState get state => _state;

  void _updateState(HomePageState newState) {
    _state = newState;
    notifyListeners();
  }

  void isUserLogged() async {
    final result = await _service.readOne(key: "user_access_token");
    if (result != null) {
      _updateState(HomePageSuccessState());
    } else {
      _updateState(HomePageErrorState());
    }
  }

  void deleteToken() async {
    await _service.deleteOne(key: "user_access_token");
    final result = await _service.readOne(key: "user_access_token");
    if (result == null) {
      _updateState(HomePageErrorState());
    }
  }
}
