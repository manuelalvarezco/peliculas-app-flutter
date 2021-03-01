import 'package:flutter/material.dart';
import 'package:peliculasapp/Movies/blocs/populares_bloc.dart';
import 'package:peliculasapp/Movies/models/movie_popular.dart';

class MovieHorizontalWidget extends StatelessWidget {
  final List<Movie> movies;
  MovieHorizontalWidget({@required this.movies});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: .3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    // Listener
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        popularsBlock.fetchPopularsMovies();
      }
    });

    return Container(
        margin: EdgeInsets.only(top: 15),
        height: _screenSize.height * 0.2,
        child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: movies.length,
          itemBuilder: (context, i) => _tarjeta(context, movies[i]),
        ));
  }

  Widget _tarjeta(BuildContext context, Movie movie) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          image: NetworkImage(movie.getPosterImg()),
          placeholder: AssetImage('assets/jar-loading.gif'),
          fit: BoxFit.cover,
          height: 160.0,
        ),
      ),
    );
  }
}
