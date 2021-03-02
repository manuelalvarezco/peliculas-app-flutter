import 'dart:async';
import 'dart:convert';

import 'package:peliculasapp/Movies/models/movie_popular.dart';
import 'package:http/http.dart' as http;

class SearchApiProvider {
  String _apiKey = 'a141476b1338ea5c7ec9b6ab6a812869';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new PopularMovies.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final resp = await _procesarRespuesta(url);

    return resp;
  }
}
