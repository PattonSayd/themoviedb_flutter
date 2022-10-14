import 'package:flutter/material.dart';

import 'news_widget_free_to_watch.dart';
import 'news_widget_leader_boards.dart';
import 'news_widget_popular.dart';
import 'news_widget_trailers.dart';
import 'news_widget_trandings.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        NewsWidgetPopular(),
        NewsWidgetFreeToWatch(),
        NewsWidgetTrailers(),
        NewsWidgetTrandings(),
        NewsWidgetLeaderboards(),
      ],
    );
  }
}
