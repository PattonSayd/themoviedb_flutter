import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../services/domain/api_client/api_client.dart';
import '../../../../services/domain/entity/movie_details.dart';
import '../../../../services/providers/session_provider.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionProvider = SessionProvider();
  final _apiClient = ApiCliet();

  final int movieId;
  MovieDetails? _movieDetails;
  bool _isFavorite = false;
  String _locale = '';
  late DateFormat _dateFormat;
  Future<void>? Function()? onSessionExpired;

  MovieDetailsModel({required this.movieId});

  MovieDetails? get movieDetails => _movieDetails;
  bool get isFavorite => _isFavorite;

  String stringFormatDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetalis();
  }

  Future<void> loadDetalis() async {
    try {
      _movieDetails = await _apiClient.movieDetails(movieId, _locale);
      final sessionId = await _sessionProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
      }
      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    final color = paletteGenerator.dominantColor!.color;
    return color;
  }

  Future<void> toggleFavorite() async {
    final sessionId = await _sessionProvider.getSessionId();
    final accountId = await _sessionProvider.getAccountId();

    if (sessionId == null || accountId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();

    try {
      await _apiClient.markAsFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaId: movieId,
        mediaType: MediaType.movie,
        isFavorite: _isFavorite,
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  _handleApiClientException(ApiClientException e) {
    switch (e.type) {
      case ApiClientExceptionType.sessionExpired:
        onSessionExpired?.call();
        break;
      default:
        print(e);
    }
  }
}
