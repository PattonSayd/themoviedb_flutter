import 'package:the_movie/app/api_client/account_api_client.dart';
import 'package:the_movie/app/api_client/auth_api_client.dart';
import '../data_providers/session_data_provider.dart';

class AuthServices {
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionProvider.getSessionId();
    final isAuth = sessionId != null;

    return isAuth;
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

  Future<void> logout() async {
    await _sessionProvider.unSetSessionId();
    await _sessionProvider.unSetAccountId();
  }
}
