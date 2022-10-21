import 'package:flutter/material.dart';
import 'package:the_movie/ui/screens/main/models/main_screen_model.dart';
import 'package:the_movie/ui/screens/movie_details/models/movie_details_model.dart';
import 'package:the_movie/ui/screens/trailer/movie_trailer_widget.dart';

import '../../ui/screens/auth/auth_screen.dart';
import '../../ui/screens/auth/models/auth_model.dart';
import '../../ui/screens/main/main_screen.dart';
import '../../ui/screens/movie_details/movie_details_screen.dart';
import '../providers/provider.dart';

abstract class AppRouteName {
  static const auth = 'auth';
  static const mainScreen = '/'; // /main_screen
  static const movieDetails = '/movie_detalis';
  static const movieTrailer = '/movie_detalis/trailer';
}

class AppRoute {
  String initialRoute(bool isAuth) =>
      isAuth ? AppRouteName.mainScreen : AppRouteName.auth;

  final routes = <String, Widget Function(BuildContext)>{
    AppRouteName.auth: (context) => StateNotifierProvider(
          create: () => AuthModel(),
          child: const AuthScreen(),
        ),
    AppRouteName.mainScreen: (context) => StateNotifierProvider(
          create: () => MainScreenModel(),
          child: const MainScreen(),
        ),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int
            ? arguments
            : 0; //  0 - для предотвращения ошибки🎈
        return MaterialPageRoute(
          builder: (context) => StateNotifierProvider(
              create: () => MovieDetailsModel(movieId: movieId),
              child: const MovieDetalisScreen()),
        );
      case AppRouteName.movieTrailer:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => MovieTrailerWidget(youTubeKey: youtubeKey),
        );
      default:
        return MaterialPageRoute(
            builder: (context) => const Text('Navigation error'));
    }
  }
}
