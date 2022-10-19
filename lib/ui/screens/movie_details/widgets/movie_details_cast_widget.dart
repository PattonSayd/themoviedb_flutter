part of '../movie_details_screen.dart';

class _MovieDetailsCastWidget extends StatelessWidget {
  const _MovieDetailsCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 2, left: 10),
            child: Text(
              'Top Billed Cast',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 240,
            child: Scrollbar(
              radius: Radius.circular(10),
              thickness: 3,
              child: _ActourCardListWigdet(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Full Cast & Crew',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ActourCardListWigdet extends StatelessWidget {
  const _ActourCardListWigdet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = StateNotifierProvider.watch<MovieDetailsModel>(context);
    final actors = model?.movieDetails?.credits.cast;
    if (actors == null || actors.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      itemCount: actors.length,
      itemExtent: 140,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black.withOpacity(0.2),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  actors[index].profilePath != null
                      ? Image.network(
                          ApiCliet.imageUrl(actors[index].profilePath!),
                          height: 133,
                          width: 140,
                          fit: BoxFit.cover,
                        )
                      : const Placeholder(
                          fallbackHeight: 133,
                          fallbackWidth: 140,
                          color: Color.fromARGB(0, 9, 9, 9)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            actors[index].name,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            actors[index].character,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
