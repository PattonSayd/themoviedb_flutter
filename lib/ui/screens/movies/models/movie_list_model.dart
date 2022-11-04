import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/domain/api_client/movie_api_client.dart';
import 'package:the_movie/domain/entity/movie.dart';
import 'package:the_movie/domain/entity/popular_movie_response.dart';

import '../../../routes/app_routes.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = MovieApiCliet();
  final _movies = <Movie>[];
  late DateFormat _dateFormat;
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgress = false;
  String _locale = '';
  String? _searchQuery;
  Timer? searcTimer;

  List<Movie> get movies => List.unmodifiable(_movies);

  String stringFormatDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    await _loadNextPage();
  }

  Future<PopularMovieResponse> _loadMovies(int nextPage, String locale) async {
    if (_searchQuery == null) {
      return await _apiClient.popularMovie(nextPage, _locale);
    } else {
      return await _apiClient.searchMovie(nextPage, locale, _searchQuery!);
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;

    try {
      final movieResponse = await _loadMovies(nextPage, _locale);
      _movies.addAll(movieResponse.movies);

      _currentPage = movieResponse.page; // текущая страница
      _totalPage = movieResponse.totalPages;

      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
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

      await _resetList();
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
