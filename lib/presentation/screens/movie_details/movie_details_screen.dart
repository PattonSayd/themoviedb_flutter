import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/presentation/theme/app_colors.dart';
import 'package:the_movie/app/routes/app_routes.dart';
import 'package:the_movie/presentation/screens/movie_details/movie_details_viewmodel.dart';

import '../../../app/api_client/image_downloader.dart';
import '../movies/radial_percent_widget.dart';

part 'movie_details_info_widget.dart';
part 'movie_details_cast_widget.dart';

class MovieDetalisScreen extends StatefulWidget {
  const MovieDetalisScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetalisScreen> createState() => _MovieDetalisScreenState();
}

class _MovieDetalisScreenState extends State<MovieDetalisScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final locale = Localizations.localeOf(context);
    Future.microtask(() =>
        context.read<MovieDetailsViewModel>().setupLocale(context, locale));
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsViewModel>();
    final data =
        context.select((MovieDetailsViewModel vm) => vm.data.posterData);
    late String fullPath = '';
    if (data.posterPath != null) {
      fullPath = ImageDownloader.imageUrl(data.posterPath!);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const _TitleWidget(),
      ),
      body: FutureBuilder(
        future: fullPath.isNotEmpty
            ? model.getImagePalette(NetworkImage(fullPath))
            : null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.theme,
                ),
              ),
            );
          }
          return ColoredBox(
            color: snapshot.data ?? Colors.black87,
            child: const _BodyWidget(),
          );
        },
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.select((MovieDetailsViewModel vm) => vm.data.title);
    return Text(title);
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _MovieDetailsInfoWidget(),
        _MovieDetailsCastWidget(),
      ],
    );
  }
}
