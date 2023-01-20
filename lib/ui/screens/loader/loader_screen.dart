import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/app/routes/app_routes.dart';
import 'package:the_movie/ui/screens/loader/loader_viewmodel.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderCubit, LoaderState>(
      listenWhen: (previous, current) => current != LoaderState.unknown,
      listener: (context, state) {
        final screen = state == LoaderState.authorized
            ? AppRouteName.mainScreen
            : AppRouteName.auth;
        Navigator.of(context).pushReplacementNamed(screen);
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
