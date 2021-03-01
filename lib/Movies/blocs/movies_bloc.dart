import 'package:peliculasapp/Movies/models/movie_model.dart';
import 'package:peliculasapp/Movies/resources/movie_repository.dart';
import 'package:rxdart/subjects.dart';

class MoviesBloc {
  final _movieRepository = MovieRepository();
  final _movies$ = BehaviorSubject<Movie>();

  BehaviorSubject<Movie> get moviesInCinema => _movies$.stream;
  BehaviorSubject<Movie> get popularsMovies => _movies$.stream;

  fetchCinemaMovies() async {
    Movie movieItem = await _movieRepository.fetcCineMovies();
    _movies$.sink.add(movieItem);
  }

  fetchPopularsMovies() async {
    Movie movieItem = await _movieRepository.fetcPopularsMovies();
    _movies$.sink.add(movieItem);
  }

  dispose() {
    _movies$.close();
  }
}

final moviesBloc = MoviesBloc();
