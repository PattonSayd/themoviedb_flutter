import 'package:flutter/material.dart';
import 'package:the_movie/services/domain/api_client/api_client.dart';
import 'package:the_movie/ui/screens/movies/models/movie_list_model.dart';

import '../../../services/providers/provider.dart';

class MoviesPolularScreen extends StatelessWidget {
  const MoviesPolularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = StateNotifierProvider.watch<MovieListModel>(context);
    return Stack(
      children: [
        ListView.builder(
            padding: const EdgeInsets.only(top: 60),
            itemCount: model?.movies.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              model?.showedMovieAtIndex(index);
              final movie = model?.movies[index];
              final posterPath = movie!.posterPath;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                          spreadRadius: 1,
                        )
                      ]),
                  clipBehavior: Clip.hardEdge,
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: InkWell(
                      onTap: () => model?.onMovieTap(context, index),
                      child: Row(
                        children: [
                          posterPath != null
                              ? Image.network(ApiCliet.imageUrl(posterPath))
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: const Placeholder()),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    movie.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    model!.stringFormatDate(movie.releaseDate),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    movie.overview,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            style: const TextStyle(fontSize: 17, color: Colors.black87),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              labelText: 'Search',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              prefixIcon: const Icon(Icons.search),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).backgroundColor, width: 2)),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12, width: 1),
              ),
            ),
            onChanged: model?.searchMovie,
          ),
        )
      ],
    );
  }
}
