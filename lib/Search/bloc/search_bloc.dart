import 'dart:async';

import 'package:peliculasapp/Movies/models/movie_popular.dart';
import 'package:peliculasapp/Search/resources/search_repository.dart';

class SearchBlock {
  final searchRepository = new SearchRepository();

  List<Movie> _movies = [];

  final _searchMoviesController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get searchMovieSink => _searchMoviesController.sink.add;

  Stream<List<Movie>> get searchMovieStream => _searchMoviesController.stream;

  Future<List<Movie>> searchMovies(String query) async {
    List<Movie> movies = await searchRepository.searchMovies(query);

    _movies.addAll(movies);

    searchMovieSink(_movies);
  }

  dispose() {
    _searchMoviesController.close();
  }
}

final searchBlock = SearchBlock();
