import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/screens/movies/movies_popular_viewmodel.dart';
import 'package:the_movie/presentation/screens/movies/movie_list_widget.dart';
import 'package:the_movie/presentation/screens/movies/search_wigdet.dart';

class MoviesPolularScreen extends StatefulWidget {
  const MoviesPolularScreen({Key? key}) : super(key: key);

  @override
  State<MoviesPolularScreen> createState() => _MoviesPolularScreenState();
}

class _MoviesPolularScreenState extends State<MoviesPolularScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MoviesPopularViewModel>().setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        MovieListWidget(),
        SearchWidget(),
      ],
    );
  }
}
