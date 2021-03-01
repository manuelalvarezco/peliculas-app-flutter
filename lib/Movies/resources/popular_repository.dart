import 'package:peliculasapp/Movies/models/movie_popular.dart';
import 'package:peliculasapp/Movies/resources/popular_api_provider.dart';

class PopularRepository {
  final popularApiProvider = PopularApiProvider();

  Future<List<Movie>> fetchPopularsMovies() => popularApiProvider.getPopulars();
}
