import 'dart:convert';

import 'package:peliculasapp/Movies/models/actor_model.dart';
import 'package:http/http.dart' as http;

class ActorApiProvider {
  String _apiKey = 'a141476b1338ea5c7ec9b6ab6a812869';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Actor>> getCast(String idMovie) async {
    final url = Uri.https(_url, '3/movie/$idMovie/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }
}
