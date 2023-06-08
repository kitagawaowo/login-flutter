import 'package:flutter/material.dart';
import 'package:movie_app/data/http_helper.dart';
import 'package:movie_app/screens/movie/movie_list.dart';

class Movies extends StatelessWidget {
  const Movies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Xtreme Movie App")),
      body: Column(
        children: [
          Expanded(
            child: MovieList(url: MovieUrl.popular.url),
          ),
          Expanded(
            child: MovieList(url: MovieUrl.upcoming.url),
          ),
          Expanded(
            child: MovieList(url: MovieUrl.topRated.url),
          ),
        ],
      ),
    );
  }
}
