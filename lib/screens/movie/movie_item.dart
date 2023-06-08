import 'package:flutter/material.dart';
import 'package:movie_app/data/movie.dart';

class MovieItem extends StatefulWidget {
  const MovieItem({super.key, required this.movie});
  final Movie movie;

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Image.network(
      'https://image.tmdb.org/t/p/w500${widget.movie.posterUrl}',
      width: size.width / 3,
    );
  }
}
