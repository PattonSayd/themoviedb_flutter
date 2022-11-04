import '../../providers/session_provider.dart';
import '../api_client/api_client.dart';

class AuthServices {
  final _apiClient = ApiCliet();

  final _sessionProvider = SessionProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionProvider.getSessionId();
    final auth = sessionId != null;
    return auth;
  }

  Future<void> login(String login, String password) async {
    final sessionId = await _apiClient.auth(
      username: login,
      password: password,
    );

    final accountId = await _apiClient.getAccountInfo(sessionId);
    await _sessionProvider.setSessionId(sessionId);
    await _sessionProvider.setAccountId(accountId);
  }
}
