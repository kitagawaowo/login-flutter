import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movie_app/data/movie.dart';
import 'package:movie_app/data/user.dart';

enum MovieUrl {

  upcoming (url: '/upcoming?'),
  popular(url: '/popular?'),
  topRated(url: '/top_rated?');

  const MovieUrl({required this.url});
  final String url;
}

class HttpHelper {
  
  final String urlApiKey = 'api_key=3cae426b920b29ed2fb1c0749f258325';
  final String urlBase = 'https://api.themoviedb.org/3/movie';

  final String urlUser = 'https://plain-marbled-muskox.glitch.me/users';



  Future<User> createUser(String username, String password) async{
  
   http.Response result = await http.post(Uri.parse(urlUser),
      headers: <String, String> {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password
      })
    );

    if (result.statusCode == HttpStatus.created){
      return User.fromJson(jsonDecode(result.body));
    } else {
      throw Exception('Faile to create user');
    }
  }


  Future<List<Movie>?> getMovies(String urlMovies) async{
    final String url = urlBase+urlMovies+urlApiKey;
    http.Response result =  await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      final List maps = jsonResponse['results'];
      List<Movie> movies = maps.map((map) => Movie.fromJson(map)).toList();
      return movies;
    } else {
      return null;
    }
  }



}