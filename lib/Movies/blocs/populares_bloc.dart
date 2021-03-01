import 'dart:async';

import 'package:peliculasapp/Movies/models/movie_popular.dart';
import 'package:peliculasapp/Movies/resources/popular_repository.dart';

class PopularsBlock {
  final popularRepository = PopularRepository();

  List<Movie> _populares = new List();

  final _popularesStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Movie>> get popularesStream => _popularesStreamController.stream;

  Future<List<Movie>> fetchPopularsMovies() async {
    List<Movie> movies = await popularRepository.fetchPopularsMovies();
    _populares.addAll(movies);
    popularesSink(_populares);

    return movies;
  }

  dispose() {
    _popularesStreamController?.close();
  }
}

final popularsBlock = PopularsBlock();
