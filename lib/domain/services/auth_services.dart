import '../../providers/session_provider.dart';

class AuthServices {
  final _sessionProvider = SessionProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionProvider.getSessionId();
    final auth = sessionId != null;
    return auth;
  }
}
