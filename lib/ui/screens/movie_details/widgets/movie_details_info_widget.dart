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
    final model = context.watch<MovieDetailsViewModel>();
    final data =
        context.select((MovieDetailsViewModel vm) => vm.data.posterData);
    final backdropPath = data.backdropPath;
    final posterPath = data.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          if (backdropPath != null)
            Image.network(ImageDownloader.imageUrl(backdropPath)),
          if (posterPath != null)
            Positioned(
              top: 20,
              left: 20,
              bottom: 20,
              child: Image.network(ImageDownloader.imageUrl(posterPath)),
            ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () => model.toggleFavorite(context),
              icon: Icon(
                color: Colors.amber,
                data.favoriteIcon,
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
    final data = context.select((MovieDetailsViewModel vm) => vm.data.nameData);
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(
          children: [
            TextSpan(
              text: data.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: data.year,
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
    var data = context.select((MovieDetailsViewModel vm) => vm.data.scoreData);

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
                    percent: data.voteAverage / 100,
                    lineWidth: 3,
                    fillColor: const Color.fromARGB(255, 10, 23, 25),
                    freeColor: const Color.fromARGB(255, 25, 54, 31),
                    lineColor: data.voteAverage > 72
                        ? const Color.fromARGB(255, 37, 203, 103)
                        : data.voteAverage < 50
                            ? const Color.fromARGB(255, 203, 37, 37)
                            : const Color.fromARGB(255, 200, 203, 37),
                    child: Text(
                      data.voteAverage.toStringAsFixed(0),
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
            onPressed: data.trailerKey != null
                ? () => Navigator.of(context).pushNamed(
                    AppRouteName.movieTrailer,
                    arguments: data.trailerKey)
                : null,
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  color: data.trailerKey != null ? Colors.white : Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  'Play Trailer',
                  style: TextStyle(
                      color:
                          data.trailerKey != null ? Colors.white : Colors.grey),
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
    final summary =
        context.select((MovieDetailsViewModel vm) => vm.data.summary);
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
            summary,
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
    final peopleData =
        context.select((MovieDetailsViewModel vm) => vm.data.peopleData);

    return Row(
      children: [
        Flexible(
          child: Wrap(
            children: [
              for (var employee in peopleData.first)
                _buildPeopleResume(
                  context,
                  fullName: employee.name,
                  jobTitle: employee.job,
                ),
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
    final overview =
        context.select((MovieDetailsViewModel vm) => vm.data.overview);

    return Text(
      overview,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
