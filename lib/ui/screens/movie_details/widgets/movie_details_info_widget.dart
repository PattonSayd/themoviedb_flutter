part of '../movie_details_screen.dart';

class _MovieDetailsInfoWidget extends StatelessWidget {
  const _MovieDetailsInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TopPosterWidget(),
        const _MovieNameWidget(),
        const _ScoreWidget(),
        const SizedBox(height: 10),
        const _SummaryWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              _buidOverwiew(),
              const SizedBox(height: 16),
              const _DescriptionWidget(),
              const SizedBox(height: 26),
              const _PeopleWidget(),
            ],
          ),
        )
      ],
    );
  }

  Text _buidOverwiew() => const Text(
        'Overview',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      );
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = StateNotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ImageDownloader.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ImageDownloader.imageUrl(posterPath))
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () => model?.toggleFavorite(),
              icon: Icon(
                color: Colors.amber,
                model?.isFavorite == true
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = StateNotifierProvider.watch<MovieDetailsModel>(context);
    var year = model?.movieDetails?.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(
          children: [
            TextSpan(
              text: model?.movieDetails?.title ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: year,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movieDetails =
        StateNotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    var voteAverage = movieDetails?.voteAverage ?? 0;
    voteAverage = voteAverage * 10;
    final videos = movieDetails?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');

    var trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: RadialPercentWidget(
                    percent: voteAverage / 100,
                    lineWidth: 3,
                    fillColor: const Color.fromARGB(255, 10, 23, 25),
                    freeColor: const Color.fromARGB(255, 25, 54, 31),
                    lineColor: voteAverage > 72
                        ? const Color.fromARGB(255, 37, 203, 103)
                        : voteAverage < 50
                            ? const Color.fromARGB(255, 203, 37, 37)
                            : const Color.fromARGB(255, 200, 203, 37),
                    child: Text(
                      voteAverage.toStringAsFixed(0),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                const Text(
                  'User Score',
                  style: TextStyle(color: Colors.white),
                )
              ],
            )),
        Container(
          width: 1,
          height: 22,
          color: Colors.grey,
        ),
        TextButton(
            onPressed: trailerKey != null
                ? () => Navigator.of(context)
                    .pushNamed(AppRouteName.movieTrailer, arguments: trailerKey)
                : null,
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  color: trailerKey != null ? Colors.white : Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  'Play Trailer',
                  style: TextStyle(
                      color: trailerKey != null ? Colors.white : Colors.grey),
                ),
              ],
            )),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = StateNotifierProvider.watch<MovieDetailsModel>(context);
    var texts = <String>[];
    final releaseDate = model?.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model!.stringFormatDate(releaseDate));
    }
    final productionCountries = model?.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      var countries = <String>[];
      for (var country in productionCountries) {
        countries.add(country.iso);
      }
      texts.add('(${countries.join(', ')})');
    }
    final runtime = model?.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');

    final genres = model?.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genr in genres) {
        genresNames.add(genr.name);
      }
      texts.add(genresNames.join(', '));
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.3)),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(0, 0, 0, 0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Text(
            texts.join(' '),
            maxLines: 3,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = StateNotifierProvider.watch<MovieDetailsModel>(context);
    final employees = model?.movieDetails?.credits.crew.take(4).toList();
    if (employees == null || employees.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        Flexible(
          child: Wrap(
            children: [
              for (var employee in employees)
                _buildPeopleResume(context,
                    fullName: employee.name, jobTitle: employee.job),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPeopleResume(context, {fullName, jobTitle}) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth / 2.05,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  jobTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      );
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = StateNotifierProvider.watch<MovieDetailsModel>(context);

    return Text(
      model?.movieDetails?.overview ?? '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
