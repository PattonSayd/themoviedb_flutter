import 'package:flutter/material.dart';
import 'package:the_movie/services/domain/api_client/api_client.dart';
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
      body: const ColoredBox(
          color: Color.fromRGBO(24, 23, 27, 1.0), child: _BodyWidget()),
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

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = StateNotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView(
      children: const [
        _MovieDetailsInfoWidget(),
        _MovieDetailsCastWidget(),
      ],
    );
  }
}
