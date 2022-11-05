import 'package:flutter/material.dart';

import '../../../../providers/session_provider.dart';
import '../../../routes/app_routes.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('TMDB'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => SessionProvider().setSessionId(null).then((value) =>
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouteName.auth, (route) => false)),
          icon: const Icon(Icons.logout_sharp),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
