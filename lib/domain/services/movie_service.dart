import 'package:the_movie/configuration/configuration.dart';

import '../api_client/movie_api_client.dart';
import '../entity/popular_movie_response.dart';

class MovieService {
  final _movieApiClient = MovieApiCliet();

  Future<PopularMovieResponse> popularMovie(int page, String locale) async =>
      _movieApiClient.popularMovie(page, locale, Configuration.apiKey);

  Future<PopularMovieResponse> searchMovie(
          int page, String locale, String query) async =>
      _movieApiClient.searchMovie(page, locale, query, Configuration.apiKey);
}
