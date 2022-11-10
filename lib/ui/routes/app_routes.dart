import 'package:flutter/material.dart';
import 'package:the_movie/domain/factories/screen_factory.dart';

abstract class AppRouteName {
  static const loader = '/';
  static const auth = '/auth';
  static const mainScreen = '/main_screen';
  static const movieDetails = '/main_screen/movie_detalis';
  static const movieTrailer = '/main_screen/movie_detalis/trailer';
}

class AppRoute {
  final routes = <String, Widget Function(BuildContext)>{
    AppRouteName.loader: (_) => ScreenFactory.assemblyLoader(),
    AppRouteName.auth: (_) => ScreenFactory.assemblyAuth(),
    AppRouteName.mainScreen: (_) => ScreenFactory.assemblyMain()
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => ScreenFactory.assemblyMovieDetails(movieId),
        );
      case AppRouteName.movieTrailer:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => ScreenFactory.assemblyMovieTrailer(youtubeKey),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Text('Navigation error'),
        );
    }
  }

  static void validationAuthRoute(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRouteName.loader, (route) => false);
  }
}
