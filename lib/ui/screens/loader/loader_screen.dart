import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/app/routes/app_routes.dart';
import 'package:the_movie/domain/blocs/loader/loader_cubit.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderCubit, LoaderState>(
      listenWhen: (previous, current) => current is! LoaderInitial,
      listener: onLoaderStateScreenChange,
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void onLoaderStateScreenChange(BuildContext context, LoaderState state) {
    final screen = state is LoaderAuthorizedState
        ? AppRouteName.mainScreen
        : AppRouteName.auth;

    Navigator.of(context).pushReplacementNamed(screen);
  }
}
