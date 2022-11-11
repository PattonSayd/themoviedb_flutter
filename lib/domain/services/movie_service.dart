import 'package:the_movie/configuration/configuration.dart';
import 'package:the_movie/domain/locale_entity.dart/movie_details_locale.dart';

import '../../providers/session_provider.dart';
import '../api_client/account_api_client.dart';
import '../api_client/movie_api_client.dart';
import '../entity/popular_movie_response.dart';

class MovieService {
  final _movieApiClient = MovieApiCliet();
  final _sessionProvider = SessionProvider();
  final _accountApiClient = AccountApiClient();

  Future<PopularMovieResponse> popularMovie(int page, String locale) async =>
      _movieApiClient.popularMovie(page, locale, Configuration.apiKey);

  Future<PopularMovieResponse> searchMovie(
          int page, String locale, String query) async =>
      _movieApiClient.searchMovie(page, locale, query, Configuration.apiKey);

  Future<MovieDetailsLocale> loadDetalis({
    required int movieId,
    required String locale,
  }) async {
    final details = await _movieApiClient.movieDetails(movieId, locale);
    final sessionId = await _sessionProvider.getSessionId();
    bool isFavorite = false;
    if (sessionId != null) {
      isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
    }
    return MovieDetailsLocale(details: details, isFavorite: isFavorite);
  }

  Future<void> updateFavorite({
    required int movieId,
    required bool isFavorite,
  }) async {
    final sessionId = await _sessionProvider.getSessionId();
    final accountId = await _sessionProvider.getAccountId();
    if (sessionId == null || accountId == null) return;

    await _accountApiClient.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaId: movieId,
      mediaType: MediaType.movie,
      isFavorite: isFavorite,
    );
  }
}
