 void _onMovieTap(int index) {
    final id = moviesList[index].id;
    Navigator.of(context).pushNamed(
      AppRouteName.movieDetails,
      arguments: id,
    );
  }