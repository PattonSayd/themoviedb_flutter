import 'package:flutter/material.dart';
import 'package:the_movie/app/app_model.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = AppModel();
  await model.checkAuth();
  runApp(MyApp(model: model));
}
