import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_movie/app/app_model.dart';
import 'package:the_movie/services/routes/app_routes.dart';

import 'theme/app_colors.dart';

class MyApp extends StatelessWidget {
  final AppModel model;
  static final appRoutes = AppRoute();
  const MyApp({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.theme,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.theme,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'EN'),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: appRoutes.initialRoute(model.isAuth),
      routes: appRoutes.routes,
      onGenerateRoute: appRoutes.onGenerateRoute,
    );
  }
}






 // onGenerateRoute: (RouteSettings settings) {
      //   return MaterialPageRoute<void>(builder: (context) {
      //     return const Scaffold(
      //       body: Center(
      //         child: Text('A navigation error has occurred.'),
      //       ),
      //     );
      //   });
      // },