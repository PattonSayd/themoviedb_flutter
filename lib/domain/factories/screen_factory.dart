import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/ui/screens/movies/movies_popular_screen.dart';

import '../../providers/provider.dart' as my_provider;
import '../../ui/screens/auth/auth_screen.dart';
import '../../ui/screens/auth/models/auth_viewmodel.dart';
import '../../ui/screens/loader/loader_screen.dart';
import '../../ui/screens/loader/viewmodel/loader_viewmodel.dart';
import '../../ui/screens/main/main_screen.dart';
import '../../ui/screens/main/viewmodel/main_viewmodel.dart';
import '../../ui/screens/movie_details/models/movie_details_model.dart';
import '../../ui/screens/movie_details/movie_details_screen.dart';
import '../../ui/screens/movies/viewmodels/movies_popular_viewmodel.dart';
import '../../ui/screens/news/news_screen.dart';
import '../../ui/screens/trailer/movie_trailer_widget.dart';
import '../../ui/screens/tv_show/tv_show_screen.dart';

class ScreenFactory {
  ScreenFactory._();

  static Widget assemblyLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderScreen(),
    );
  }

  static Widget assemblyAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const AuthScreen(),
    );
  }

  static Widget assemblyMain() {
    return ChangeNotifierProvider(
      create: (_) => MainViewModel(),
      child: const MainScreen(),
    );
  }

  static Widget assemblyMovieDetails(int movieId) {
    return my_provider.StateNotifierProvider(
      create: () => MovieDetailsModel(movieId: movieId),
      child: const MovieDetalisScreen(),
    );
  }

  static Widget assemblyMovieTrailer(String youtubeKey) {
    return MovieTrailerWidget(youTubeKey: youtubeKey);
  }

  static Widget assemblyMoviesPolular() {
    return ChangeNotifierProvider(
      create: (_) => MoviesPopularViewModel(),
      child: const MoviesPolularScreen(),
    );
  }

  static Widget assemblyTVShow() => const TVShowScreenWidget();

  static Widget assemblyNews() => const NewsScreen();
}
