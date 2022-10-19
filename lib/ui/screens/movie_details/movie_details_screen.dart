import 'package:flutter/material.dart';
import 'package:the_movie/services/providers/provider.dart';
import 'package:the_movie/ui/screens/movie_details/models/movie_details_model.dart';

import '../../../app/resources/resources.dart';
import '../movies/widgets/radial_percent_widget.dart';

part 'widgets/movie_details_info_widget.dart';
part 'widgets/movie_details_cast_widget.dart';

class MovieDetalisScreen extends StatefulWidget {
  const MovieDetalisScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieDetalisScreen> createState() => _MovieDetalisScreenState();
}

class _MovieDetalisScreenState extends State<MovieDetalisScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    StateNotifierProvider.read<MovieDetailsModel>(context)
        ?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const _TitleWidget(),
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(24, 23, 27, 1.0),
        child: ListView(
          children: const [
            // Text(),
            _MovieDetailsInfoWidget(),
            _MovieDetailsCastWidget(),
          ],
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = StateNotifierProvider.watch<MovieDetailsModel>(context);
    return Text(model?.movieDetails?.title ?? 'Loading...');
  }
}
