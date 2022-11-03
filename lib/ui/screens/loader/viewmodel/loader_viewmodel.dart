import 'package:flutter/cupertino.dart';
import 'package:the_movie/ui/routes/app_routes.dart';

import '../../../../domain/services/auth_services.dart';

class LoaderViewModel {
  BuildContext context;
  final _authService = AuthServices();

  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    await _authService.isAuth().then((auth) {
      final nextScreen = auth ? AppRouteName.mainScreen : AppRouteName.auth;
      Navigator.of(context).pushReplacementNamed(nextScreen);
    });
  }
}
