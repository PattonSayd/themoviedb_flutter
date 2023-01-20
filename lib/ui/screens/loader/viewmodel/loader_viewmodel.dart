import 'package:flutter/cupertino.dart';
import 'package:the_movie/app/routes/app_routes.dart';

import '../../../../domain/services/auth_services.dart';

class LoaderViewModel {
  BuildContext context;
  final _authService = AuthServices();

  LoaderViewModel(this.context) {
    initial();
  }

  Future<void> initial() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    await _authService.isAuth().then((isAuth) {
      final screen = isAuth ? AppRouteName.mainScreen : AppRouteName.auth;
      Navigator.of(context).pushReplacementNamed(screen);
    });
  }
}
