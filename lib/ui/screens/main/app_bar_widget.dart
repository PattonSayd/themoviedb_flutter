import 'package:flutter/material.dart';
import 'package:the_movie/domain/services/auth_services.dart';

import '../../../app/routes/app_routes.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthServices();
    return AppBar(
      title: const Text('TMDB'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            authService.logout();
            AppRoute.validationAuthRoute(context);
          },
          icon: const Icon(Icons.logout_sharp),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
