import '../services/providers/session_provider.dart';

class AppModel {
  final _sessionProvider = SessionProvider();
  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionProvider.getSessionId();
    _isAuth = sessionId != null;
  }
}
