import 'package:flutter/material.dart';
import 'package:peliculasapp/Movies/blocs/movies_bloc.dart';
import 'package:peliculasapp/Movies/blocs/populares_bloc.dart';
import 'package:peliculasapp/Movies/models/movie_model.dart';
import 'package:peliculasapp/Widgets/movie_horizontal_widget.dart';
import 'package:peliculasapp/Widgets/swiper_card_widget.dart';

class MovieListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas App'),
          backgroundColor: Colors.indigoAccent,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_moviesInCatelera(), _popularsMovies(context)],
          ),
        ));
  }

  Widget _moviesInCatelera() {
    moviesBloc.fetchCinemaMovies();

    return StreamBuilder(
        stream: moviesBloc.moviesInCinema,
        builder: (context, AsyncSnapshot<Movie> snapshot) {
          if (snapshot.hasData) {
            return SiperCardWidget(context: context, snapshot: snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return Container(
              height: 200, child: Center(child: CircularProgressIndicator()));
        });
  }

  Widget _popularsMovies(BuildContext context) {
    popularsBlock.fetchPopularsMovies();
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child:
                Text('Populars', style: Theme.of(context).textTheme.subtitle1),
          ),
          SizedBox(height: 5),
          StreamBuilder(
              stream: popularsBlock.popularesStream,
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontalWidget(movies: snapshot.data);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Container(
                    height: 400,
                    child: Center(child: CircularProgressIndicator()));
              })
        ],
      ),
    );
  }
}
