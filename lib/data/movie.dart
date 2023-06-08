class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterUrl});

  Movie.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['original_title'],
            overview: json['overview'],
            posterUrl: json['poster_path']);
}
