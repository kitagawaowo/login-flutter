import 'package:flutter/material.dart';
import 'package:movie_app/data/http_helper.dart';
import 'package:movie_app/data/movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key, required this.url});
  final String url;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  HttpHelper? _httpHelper;
  List<Movie>? _movies;
  PageController? _pageController;
  double? _currentPage;

  initialize() async {
    _movies = await _httpHelper?.getMovies(widget.url);
    setState(() {
      _movies = _movies;
    });
  }

  _pageControllerListener() {
    setState(() {
      _currentPage = _pageController?.page;
    });
  }

  @override
  void initState() {
    _movies = List.empty();
    _httpHelper = HttpHelper();
    _currentPage = 0;
    _pageController = PageController(
      viewportFraction: 1 / 3,
    );
    _pageController?.addListener(_pageControllerListener);
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.removeListener(_pageControllerListener);
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final movieHeight = size.height / 5;

    return PageView.builder(
      controller: _pageController,
      itemCount: _movies?.length,
      itemBuilder: (context, index) {
        final result = _currentPage! - index;
        final value = 1 - (result * 0 / 4).abs();
        final movie = _movies![index];
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterUrl}',
                        height: movieHeight,
                        fit: BoxFit.cover
                      ),
                      SizedBox(
                        height: 30,
                        child: Text(
                          movie.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
