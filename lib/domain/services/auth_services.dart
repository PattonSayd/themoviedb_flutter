import 'package:the_movie/domain/api_client/account_api_client.dart';
import 'package:the_movie/domain/api_client/auth_api_client.dart';

import '../../providers/session_provider.dart';

class AuthServices {
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();

  final _sessionProvider = SessionProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionProvider.getSessionId();
    final auth = sessionId != null;
    return auth;
  }

  Future<void> login(String login, String password) async {
    final sessionId = await _authApiClient.auth(
      username: login,
      password: password,
    );

    final accountId = await _accountApiClient.getAccountInfo(sessionId);
    await _sessionProvider.setSessionId(sessionId);
    await _sessionProvider.setAccountId(accountId);
  }
}
