import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:the_movie/app/repositories/auth_repository/auth_repository_bloc.dart';
import 'package:the_movie/presentation/screens/movies/movies_popular_screen.dart';

import '../repositories/auth_repository/auth_repository_state.dart';
import '../../presentation/blocs/loader_cubit/loader_cubit.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/auth/auth_viewmodel.dart';
import '../../presentation/screens/loader/loader_screen.dart';
import '../../presentation/screens/main/main_screen.dart';
import '../../presentation/screens/main/main_viewmodel.dart';
import '../../presentation/screens/movie_details/movie_details_screen.dart';
import '../../presentation/screens/movie_details/movie_details_viewmodel.dart';
import '../../presentation/screens/movies/movies_popular_viewmodel.dart';
import '../../presentation/screens/news/news_screen.dart';
import '../../presentation/screens/trailer/movie_trailer_widget.dart';
import '../../presentation/screens/tv_show/tv_show_screen.dart';

class ScreenFactory {
  static AuthRepositoryBloc? _authBloc;

  static Widget assemblyLoader() {
    final authBloc = _authBloc ?? AuthRepositoryBloc(AuthRepositoryInitial());
    _authBloc ??= authBloc;

    return BlocProvider<LoaderCubit>(
      create: (context) => LoaderCubit(LoaderInitial(), authBloc),
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
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsViewModel(movieId: movieId),
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
