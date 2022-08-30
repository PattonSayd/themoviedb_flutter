import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:the_movie/screens/movies/muvies_popular_screen.dart';
import 'package:the_movie/theme/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('News'),
    MoviesPolularScreen(),
    Text('Tv Show'),
  ];

  void _onSelectTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TMDB')),
      body: Center(
        child: Container(
          color: Colors.white,
          child: _widgetOptions[_selectedTab],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.darkBlue,
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
