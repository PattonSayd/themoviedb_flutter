import 'package:flutter/material.dart';
import 'package:the_movie/screens/movies/movie_details/movie_details_info_screen.dart';
import 'package:the_movie/screens/movies/movie_details/movie_details_cast_screen.dart';

class MovieDetalisScreen extends StatefulWidget {
  final int id;
  const MovieDetalisScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MovieDetalisScreen> createState() => _MovieDetalisScreenState();
}

class _MovieDetalisScreenState extends State<MovieDetalisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Film name'),
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(24, 23, 27, 1.0),
        child: ListView(
          children: const [
            MovieDetailsInfoScreen(),
            MovieDetailsCastScreen(),
          ],
        ),
      ),
    );
  }
}
