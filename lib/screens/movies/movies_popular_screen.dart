import 'package:flutter/material.dart';
import 'package:the_movie/screens/movies/models/movies_list.dart';

class MoviesPolularScreen extends StatefulWidget {
  const MoviesPolularScreen({Key? key}) : super(key: key);

  @override
  State<MoviesPolularScreen> createState() => _MoviesPolularScreenState();
}

class _MoviesPolularScreenState extends State<MoviesPolularScreen> {
  List<Movies> moviesList = MoviesList.movies;
  final _searchController = TextEditingController();
  var _filterMovies = <Movies>[];

  void _searchMovies() {
    if (_searchController.text.isNotEmpty) {
      _filterMovies = moviesList.where((Movies movie) {
        return movie.title
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }).toList();
    } else {
      _filterMovies = moviesList;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filterMovies = moviesList;

    _searchController.addListener(_searchMovies);
  }

  @override
  void dispose() {
    super.dispose();
    // _searchController.dispose();
    // _searchController.removeListener(() {});
  }

  void _onMovieTap(int index) {
    final id = moviesList[index].id;
    Navigator.of(context).pushNamed(
      '/main_screen/movie_detalis',
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            padding: const EdgeInsets.only(top: 60),
            itemCount: _filterMovies.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              final movie = _filterMovies[index];
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
                      onTap: () => _onMovieTap(index),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(movie.imageName),
                          ),
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
                                    movie.time,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    movie.description,
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
            controller: _searchController,
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
          ),
        )
      ],
    );
  }
}
