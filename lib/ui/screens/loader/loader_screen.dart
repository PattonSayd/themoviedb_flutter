import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/ui/screens/loader/viewmodel/loader_viewmodel.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
