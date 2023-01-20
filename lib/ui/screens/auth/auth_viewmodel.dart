import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:the_movie/domain/services/auth_services.dart';
import 'package:the_movie/app/routes/app_routes.dart';

import '../../../domain/api_client/api_client_exceptions.dart';

class AuthViewModel extends ChangeNotifier {
  final _authServices = AuthServices();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final navigator = Navigator.of(context);
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _updateState('Fill in your login and password', false);
      return;
    }

    _updateState(null, true);
    _errorMessage = await _login(login, password);

    if (_errorMessage == null) {
      navigator.pushNamedAndRemoveUntil(AppRouteName.loader, (route) => false);
    } else {
      _updateState(_errorMessage, false);
    }
  }

  Future<String?> _login(String login, String password) async {
    try {
      await _authServices.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'Server not available, please check your internet connection';
        case ApiClientExceptionType.auth:
          return 'Incorrect login or password';
        case ApiClientExceptionType.other:
          return 'An error occurred, please try again';
        case ApiClientExceptionType.sessionExpired:
          return 'Reset your session';
      }
    } catch (e) {
      return 'An error occurred, please try again';
    }

    return null;
  }

  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}
