import 'package:peliculasapp/Movies/models/movie_popular.dart';
import 'package:peliculasapp/Search/resources/search_api_provider.dart';

class SearchRepository {
  final _searchApiProvider = SearchApiProvider();

  Future<List<Movie>> searchMovies(String query) =>
      _searchApiProvider.searchMovies(query);
}
