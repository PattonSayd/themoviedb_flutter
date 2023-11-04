import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:the_movie/Library/localized_storage.dart';
import 'package:the_movie/app/services/auth_services.dart';
import 'package:the_movie/app/services/movie_service.dart';
import 'package:the_movie/app/routes/app_routes.dart';

import '../../../app/api_client/api_client_exceptions.dart';
import '../../../domain/entity/movie_details.dart';

class MovieDetailsDataItem {
  String title = '';
  String overview = '';
  String summary = '';
  MovieDetailsPosterDataItem posterData = const MovieDetailsPosterDataItem();
  MovieDetailsMovieNameDataItem nameData =
      const MovieDetailsMovieNameDataItem();
  MovieDetailsScoreDataItem scoreData =
      const MovieDetailsScoreDataItem(voteAverage: 0);
  List<List<MovieDetailsPeopleDataItem>> peopleData = const [];
  List<MovieDetailsActourDataItem> actorsData = const [];
}

class MovieDetailsPosterDataItem {
  final String? backdropPath;
  final String? posterPath;
  final bool isFavorite;

  IconData get favoriteIcon =>
      isFavorite ? Icons.favorite : Icons.favorite_border;

  const MovieDetailsPosterDataItem({
    this.backdropPath,
    this.posterPath,
    this.isFavorite = false,
  });

  MovieDetailsPosterDataItem copyWith({
    String? backdropPath,
    String? posterPath,
    bool? isFavorite,
  }) {
    return MovieDetailsPosterDataItem(
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MovieDetailsMovieNameDataItem {
  final String? name;
  final String? year;
  const MovieDetailsMovieNameDataItem({
    this.name,
    this.year,
  });
}

class MovieDetailsScoreDataItem {
  final double voteAverage;
  final String? trailerKey;
  const MovieDetailsScoreDataItem({
    required this.voteAverage,
    this.trailerKey,
  });
}

class MovieDetailsPeopleDataItem {
  String name;
  String job;
  MovieDetailsPeopleDataItem({
    required this.name,
    required this.job,
  });
}

class MovieDetailsActourDataItem {
  final String name;
  final String character;
  final String profilePath;
  const MovieDetailsActourDataItem({
    required this.name,
    required this.character,
    required this.profilePath,
  });
}

class MovieDetailsViewModel extends ChangeNotifier {
  final _authService = AuthServices();
  final _movieService = MovieService();

  final int movieId;
  final data = MovieDetailsDataItem();
  final _localeStorage = LocalizedStorage();
  late DateFormat _dateFormat;

  MovieDetailsViewModel({required this.movieId});

  Future<void> setupLocale(BuildContext context, Locale locale) async {
    if (!_localeStorage.updateData(locale)) return;
    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    updateData(null, false);
    await loadDetalis(context);
  }

  Future<void> loadDetalis(BuildContext context) async {
    try {
      final details = await _movieService.loadDetalis(
          movieId: movieId, locale: _localeStorage.localeTag);

      updateData(details.details, details.isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  void updateData(MovieDetails? details, bool isFavorite) {
    data.title = _makeTitle(details);
    data.overview = _makeOverview(details);
    data.posterData = _makePosterData(details, isFavorite);
    data.nameData = _makeNameData(details);
    data.scoreData = _makeScoreData(details);
    data.summary = _makeSummary(details);
    data.peopleData = _makePeopleData(details);
    data.actorsData = _makeActourData(details);
    notifyListeners();
  }

  String _makeTitle(MovieDetails? details) {
    return details?.title ?? 'Loading...';
  }

  String _makeOverview(MovieDetails? details) {
    return details?.overview ?? '';
  }

  MovieDetailsPosterDataItem _makePosterData(
    MovieDetails? details,
    bool isFavorite,
  ) {
    return MovieDetailsPosterDataItem(
      backdropPath: details?.backdropPath,
      posterPath: details?.posterPath,
      isFavorite: isFavorite,
    );
  }

  MovieDetailsMovieNameDataItem _makeNameData(MovieDetails? details) {
    String? year = details?.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    return MovieDetailsMovieNameDataItem(name: details?.title, year: year);
  }

  MovieDetailsScoreDataItem _makeScoreData(MovieDetails? details) {
    final voteAverage = details?.voteAverage ?? 0;
    final videos = details?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    var trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    return MovieDetailsScoreDataItem(
      voteAverage: voteAverage * 10,
      trailerKey: trailerKey,
    );
  }

  String _makeSummary(MovieDetails? details) {
    var texts = <String>[];
    final releaseDate = details?.releaseDate;
    if (releaseDate != null) {
      texts.add(_dateFormat.format(releaseDate));
    }
    final productionCountries = details?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      var countries = <String>[];
      for (var country in productionCountries) {
        countries.add(country.iso);
      }
      texts.add('(${countries.join(', ')})');
    }
    final runtime = details?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');

    final genres = details?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genr in genres) {
        genresNames.add(genr.name);
      }
      texts.add(genresNames.join(', '));
    }
    return texts.join(' ');
  }

  List<List<MovieDetailsPeopleDataItem>> _makePeopleData(
      MovieDetails? details) {
    var crews = details?.credits.crew
        .map((e) => MovieDetailsPeopleDataItem(name: e.name, job: e.job))
        .toList();
    crews = crews?.take(4).toList();
    final crewChuncks = <List<MovieDetailsPeopleDataItem>>[];
    if (crews != null && crews.isNotEmpty) {
      crewChuncks.add(crews);
    }
    return crewChuncks;
  }

  List<MovieDetailsActourDataItem> _makeActourData(MovieDetails? details) {
    final cast = details?.credits.cast
        .map((e) => MovieDetailsActourDataItem(
              name: e.name,
              character: e.character,
              profilePath: e.profilePath ?? '',
            ))
        .toList();

    return cast ?? [];
  }

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    final color = paletteGenerator.dominantColor!.color;
    return color;
  }

  Future<void> toggleFavorite(BuildContext context) async {
    data.posterData = data.posterData.copyWith(
      isFavorite: !data.posterData.isFavorite,
    );
    notifyListeners();

    try {
      await _movieService.updateFavorite(
        movieId: movieId,
        isFavorite: data.posterData.isFavorite,
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  _handleApiClientException(ApiClientException e, BuildContext context) {
    switch (e.type) {
      case ApiClientExceptionType.sessionExpired:
        _authService.logout();
        AppRoute.validationAuthRoute(context);
        break;
      default:
        debugPrint(e.toString());
    }
  }
}
