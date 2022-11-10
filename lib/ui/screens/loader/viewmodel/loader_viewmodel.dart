import 'package:flutter/cupertino.dart';
import 'package:the_movie/ui/routes/app_routes.dart';

import '../../../../domain/services/auth_services.dart';

class LoaderViewModel {
  BuildContext context;
  final _authService = AuthServices();

  LoaderViewModel(this.context) {
    initState();
  }

  Future<void> initState() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    await _authService.isAuth().then((isAuth) {
      final screen = isAuth ? AppRouteName.mainScreen : AppRouteName.auth;
      Navigator.of(context).pushReplacementNamed(screen);
    });
  }
}
