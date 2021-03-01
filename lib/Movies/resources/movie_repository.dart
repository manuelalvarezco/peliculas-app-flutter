import 'package:peliculasapp/Movies/models/movie_model.dart';
import 'package:peliculasapp/Movies/resources/movie_api_provider.dart';

class MovieRepository {
  final movieApiProvider = MovieApiProvider();

  Future<Movie> fetcCineMovies() => movieApiProvider.getEnCines();

  Future<Movie> fetcPopularsMovies() => movieApiProvider.getPopulars();
}
