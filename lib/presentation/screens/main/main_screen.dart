import 'package:flutter/material.dart';
import 'package:the_movie/presentation/screens/main/app_bar_widget.dart';
import 'package:the_movie/presentation/screens/main/body_widget.dart';
import 'package:the_movie/presentation/screens/main/nav_bar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   movieListModel.setupLocale(context);
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppBarWidget(),
        body: BodyWidget(),
        bottomNavigationBar: NavBarWidget());
  }
}
