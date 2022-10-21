import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:the_movie/services/providers/provider.dart';
import 'package:the_movie/services/providers/session_provider.dart';
import 'package:the_movie/ui/screens/movies/models/movie_list_model.dart';
import 'package:the_movie/ui/screens/movies/movies_popular_screen.dart';
import 'package:the_movie/app/theme/app_colors.dart';

import '../../../services/routes/app_routes.dart';
import '../news/news_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 1;
  final movieListModel = MovieListModel();

  void _onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    movieListModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => SessionProvider().setSessionId(null).then(
                (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRouteName.auth, (route) => false)),
            icon: const Icon(Icons.logout_sharp),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: IndexedStack(
          index: _selectedTab,
          children: [
            const NewsScreen(),
            StateNotifierProvider(
              create: () => movieListModel,
              isDisposeModel: false,
              child: const MoviesPolularScreen(),
            ),
            const Text('Tv Show'),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.theme,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 6,
          ),
          child: GNav(
            selectedIndex: _selectedTab,
            hoverColor: const Color.fromARGB(230, 4, 46, 81),
            tabBorderRadius: 4,
            color: Colors.white54,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(230, 4, 46, 81),
            padding: const EdgeInsets.all(8),
            gap: 6,
            onTabChange: _onSelectTab,
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
      ),
    );
  }
}
