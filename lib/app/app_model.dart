import 'package:flutter/cupertino.dart';
import 'package:the_movie/ui/routes/app_routes.dart';

import '../providers/session_provider.dart';

class AppModel {
  final _sessionProvider = SessionProvider();
  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionProvider.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSession(BuildContext context) async {
    await _sessionProvider.setSessionId(null);
    await _sessionProvider.setAccountId(null).then((value) =>
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRouteName.auth, (route) => false));
  }
}
