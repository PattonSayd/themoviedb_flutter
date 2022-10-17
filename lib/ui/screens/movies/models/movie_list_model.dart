import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/services/domain/api_client/api_client.dart';
import 'package:the_movie/services/domain/entity/movie.dart';

import '../../../../services/routes/app_routes.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiCliet();
  final _movies = <Movie>[];

  List<Movie> get movies => List.unmodifiable(_movies);

  late DateFormat _dateFormat;
  String _locale = '';

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _dateFormat = DateFormat.yMMMEd(locale);
    _locale = locale;
    _movies.clear();
    _loadMovies();
  }

  String stringFormatDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> _loadMovies() async {
    final movieResponse = await _apiClient.popularMovie(1, _locale);
    _movies.addAll(movieResponse.movies);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      AppRouteName.movieDetails,
      arguments: id,
    );
  }
}
