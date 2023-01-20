import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/ui/screens/movies/movies_popular_viewmodel.dart';
import 'package:the_movie/ui/screens/movies/movie_list_widget.dart';
import 'package:the_movie/ui/screens/movies/search_wigdet.dart';

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
    return Stack(
      children: const [
        MovieListWidget(),
        SearchWidget(),
      ],
    );
  }
}
