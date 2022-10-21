import 'package:flutter/material.dart';
import 'package:the_movie/app/app_model.dart';
import 'package:the_movie/services/providers/provider.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = AppModel();
  await model.checkAuth();
  runApp(
    Provider(
      model: model,
      child: const MyApp(),
    ),
  );
}
