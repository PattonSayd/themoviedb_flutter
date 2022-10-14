import 'package:flutter/material.dart';
import 'package:the_movie/ui/screens/main/models/main_screen_model.dart';

import '../../ui/screens/auth/auth_screen.dart';
import '../../ui/screens/auth/models/auth_model.dart';
import '../../ui/screens/main/main_screen.dart';
import '../../ui/screens/movie_details/movie_details_screen.dart';
import '../providers/provider.dart';

// class AppRoutes {
//   const AppRoutes._();

//   static void to(context, String alias) {
//     Navigator.pushReplacementNamed(context, alias);
//   }

//   static void off(context, String alias, [int? id]) {
//     Navigator.pushNamed(context, alias, arguments: id);
//   }

//   static void back(context) {
//     Navigator.pop(context);
//   }

abstract class AppRouteName {
  static const auth = 'auth';
  static const mainScreen = '/'; // /main_screen
  static const movieDetails = '/movie_detalis';
}

class AppRoute {
  String initialRoute(bool isAuth) =>
      isAuth ? AppRouteName.mainScreen : AppRouteName.auth;

  final routes = <String, Widget Function(BuildContext)>{
    AppRouteName.auth: (context) => NotifierProvider(
          model: AuthModel(),
          child: const AuthScreen(),
        ),
    AppRouteName.mainScreen: (context) =>
        NotifierProvider(model: MainScreenModel(), child: const MainScreen()),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int
            ? arguments
            : 0; //  0 - для предотвращения ошибки🎈🎈🎈🎈🎈
        return MaterialPageRoute(
          builder: (context) => MovieDetalisScreen(id: movieId),
        );
      default:
        return MaterialPageRoute(
            builder: (context) => const Text('Navigation error'));
    }
  }
}
