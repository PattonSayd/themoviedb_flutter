import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/ui/theme/app_colors.dart';
import 'package:the_movie/ui/routes/app_routes.dart';
import 'package:the_movie/ui/screens/movie_details/viewmodel/movie_details_viewmodel.dart';

import '../../../domain/api_client/image_downloader.dart';
import '../movies/widgets/radial_percent_widget.dart';

part 'widgets/movie_details_info_widget.dart';
part 'widgets/movie_details_cast_widget.dart';

class MovieDetalisScreen extends StatefulWidget {
  const MovieDetalisScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetalisScreen> createState() => _MovieDetalisScreenState();
}

class _MovieDetalisScreenState extends State<MovieDetalisScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(
      () => context.read<MovieDetailsViewModel>().setupLocale(context),
    );
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
                width: 100,
                height: 3,
                child: LinearProgressIndicator(
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
