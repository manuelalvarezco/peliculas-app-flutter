import 'dart:async';
import 'dart:convert';

import 'package:peliculasapp/Movies/models/movie_popular.dart';
import 'package:http/http.dart' as http;

class PopularApiProvider {
  String _apiKey = 'a141476b1338ea5c7ec9b6ab6a812869';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularsPage = 1;

  Future<List<Movie>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new PopularMovies.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Movie>> getPopulars() async {
    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    return resp;
  }
}
