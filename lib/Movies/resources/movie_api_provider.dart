import 'dart:convert';

import 'package:peliculasapp/Movies/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieApiProvider {
  String _apiKey = 'a141476b1338ea5c7ec9b6ab6a812869';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularsPage = 0;

  Future<Movie> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Movie.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<Movie> getPopulars() async {
    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString()
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Movie.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
