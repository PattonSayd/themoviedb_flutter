import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/services/domain/api_client/api_client.dart';
import 'package:the_movie/services/domain/entity/movie.dart';

import '../../../../services/routes/app_routes.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiCliet();
  final _movies = <Movie>[];
  late DateFormat _dateFormat;
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgress = false;
  String _locale = '';

  List<Movie> get movies => List.unmodifiable(_movies);

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    _loadMovies();
  }

  String stringFormatDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> _loadMovies() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;

    try {
      final movieResponse = await _apiClient.popularMovie(nextPage, _locale);
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
    _loadMovies();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      AppRouteName.movieDetails,
      arguments: id,
    );
  }
}
