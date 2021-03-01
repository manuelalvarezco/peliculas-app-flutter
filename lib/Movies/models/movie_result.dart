class MovieResult {
  int voteCount;
  int id;
  bool video;
  var voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds = [];
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

// viene del api
  MovieResult(result) {
    voteCount = result['vote_count'];
    id = result['id'];
    video = result['video'];
    voteAverage = result['vote_average'] / 1;
    title = result['title'];
    popularity = result['popularity'] / 1;
    posterPath = result['poster_path'];
    originalLanguage = result['original_language'];
    originalTitle = result['original_title'];
    genreIds = result['genre_ids'].cast<int>();
    backdropPath = result['backdrop_path'];
    adult = result['adult'];
    overview = result['overview'];
    releaseDate = result['release_date'];
  }
}
