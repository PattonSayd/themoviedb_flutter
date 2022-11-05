import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_colors.dart';
import '../viewmodel/main_viewmodel.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainViewModel>();
    return Container(
      color: AppColors.theme,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        child: GNav(
          selectedIndex: model.selectedTab,
          hoverColor: const Color.fromARGB(230, 4, 46, 81),
          tabBorderRadius: 4,
          color: Colors.white54,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(230, 4, 46, 81),
          padding: const EdgeInsets.all(8),
          gap: 6,
          onTabChange: model.onSelectTab,
          tabs: const [
            GButton(
              icon: Icons.now_widgets,
              text: 'News',
            ),
            GButton(
              icon: Icons.movie_filter,
              text: 'Movies',
            ),
            GButton(
              icon: Icons.tv,
              text: 'TV Show',
            ),
          ],
        ),
      ),
    );
  }
}
