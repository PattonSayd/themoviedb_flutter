// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/Library/paginator.dart';

import 'package:the_movie/domain/services/movie_service.dart';

import '../../../../domain/entity/movie.dart';
import '../../../routes/app_routes.dart';

class MoviesDataItem {
  final int id;
  final String? posterPath;
  final String title;
  final String releaseDate;
  final String overview;

  MoviesDataItem({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.overview,
  });
}

class MoviesPopularViewModel extends ChangeNotifier {
  final _movieService = MovieService();
  var _movies = <MoviesDataItem>[];
  late final Paginator<Movie> _popularMoviePaginator;
  late final Paginator<Movie> _searchMoviePaginator;
  late DateFormat _dateFormat;
  Timer? searcTimer;
  String _locale = '';
  String? _searchQuery;

  bool get isSearchMode {
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }

  List<MoviesDataItem> get movies => List.unmodifiable(_movies);

  MoviesPopularViewModel() {
    _popularMoviePaginator = Paginator<Movie>((page) async {
      final result = await _movieService.popularMovie(page, _locale);
      return PaginatorLoad(
        data: result.movies,
        currentPage: result.page,
        totalPage: result.totalPages,
      );
    });

    _searchMoviePaginator = Paginator<Movie>((page) async {
      final result =
          await _movieService.searchMovie(page, _locale, _searchQuery ?? '');
      return PaginatorLoad(
        data: result.movies,
        currentPage: result.page,
        totalPage: result.totalPages,
      );
    });
  }

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    await _popularMoviePaginator.reset();
    await _searchMoviePaginator.reset();
    _movies.clear();
    await _loadNextPage();
  }

  Future<void> _loadNextPage() async {
    if (isSearchMode) {
      await _searchMoviePaginator.loadNextPage();
      _movies = _searchMoviePaginator.data.map(_makeMoviesDataItem).toList();
    } else {
      await _popularMoviePaginator.loadNextPage();
      _movies = _popularMoviePaginator.data.map(_makeMoviesDataItem).toList();
    }

    notifyListeners();
  }

  MoviesDataItem _makeMoviesDataItem(Movie movie) {
    final movieReleaseDate = movie.releaseDate;
    final releaseDate =
        movieReleaseDate != null ? _dateFormat.format(movieReleaseDate) : '';

    return MoviesDataItem(
      id: movie.id,
      posterPath: movie.posterPath,
      title: movie.title,
      releaseDate: releaseDate,
      overview: movie.overview,
    );
  }

  void showedMovieAtIndex(index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }

  Future<void> searchMovie(String text) async {
    searcTimer?.cancel();
    searcTimer = Timer(const Duration(milliseconds: 300), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;

      _movies.clear();
      if (isSearchMode) {
        await _searchMoviePaginator.reset();
      }
      _loadNextPage();
    });
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      AppRouteName.movieDetails,
      arguments: id,
    );
  }
}
