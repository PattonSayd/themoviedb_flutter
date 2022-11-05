import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/movies_popular_viewmodel.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MoviesPopularViewModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        style: const TextStyle(fontSize: 17, color: Colors.black87),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          labelText: 'Search',
          filled: true,
          fillColor: Colors.white.withAlpha(235),
          prefixIcon: const Icon(Icons.search),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).backgroundColor, width: 2)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12, width: 1),
          ),
        ),
        onChanged: model.searchMovie,
      ),
    );
  }
}
