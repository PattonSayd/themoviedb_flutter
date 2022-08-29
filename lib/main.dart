import 'package:flutter/material.dart';
import 'package:the_movie/screens/auth/auth_screen.dart';
import 'package:the_movie/screens/main/main_screen.dart';
import 'package:the_movie/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBlue,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkBlue,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/main_screen': (context) => const MainScreen(),
        '/': (context) => const AuthScreen(),
      },
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('A navigation error has occurred.'),
            ),
          );
        });
      },
    );
  }
}
