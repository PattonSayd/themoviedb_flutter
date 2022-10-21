import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:the_movie/services/domain/api_client/api_client.dart';
import 'package:the_movie/services/providers/session_provider.dart';
import 'package:the_movie/services/routes/app_routes.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiCliet();
  final _sessionProvider = SessionProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _authInProgress = false;
  bool get canStartAuth => !_authInProgress;
  bool get authInProgress => _authInProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Fill in your login and password';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _authInProgress = true;
    notifyListeners();

    String? sessionId;
    int? accountId;

    try {
      sessionId = await _apiClient.auth(username: login, password: password);
      accountId = await _apiClient.getAccountInfo(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage =
              'Server not available, please check your internet connection';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Incorrect login or password';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'An error occurred, please try again';
          break;
        case ApiClientExceptionType.sessionExpired:
          _errorMessage = 'Reset your session';

          break;
      }
    } catch (e) {
      _errorMessage = 'An error occurred, please try again';
    }

    _authInProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null || accountId == null) {
      _errorMessage = 'Unknown error, please try again';
      notifyListeners();
      return;
    }
    await _sessionProvider.setSessionId(sessionId);
    await _sessionProvider.setAccountId(accountId).then(
          (value) => Navigator.of(context)
              .pushReplacementNamed(AppRouteName.mainScreen),
        );
  }
}
