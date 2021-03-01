import 'movie_result.dart';

class Movie {
  int page;
  int totalResult;
  int totalPage;
  List<MovieResult> results = [];

  Movie({this.page, this.totalResult, this.totalPage, this.results});

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    _result() {
      List<MovieResult> temp = [];
      for (int i = 0; i < parsedJson['results'].length; i++) {
        MovieResult result = MovieResult(parsedJson['results'][i]);
        temp.add(result);
      }
      return temp;
    }

    return Movie(
        page: parsedJson['page'],
        totalResult: parsedJson['totalresults'],
        totalPage: parsedJson['total_pages'],
        results: _result());
  }
}
