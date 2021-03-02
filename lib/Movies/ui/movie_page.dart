import 'package:flutter/material.dart';
import 'package:peliculasapp/Movies/blocs/actors_bloc.dart';
import 'package:peliculasapp/Movies/models/actor_model.dart';
import 'package:peliculasapp/Movies/models/movie_popular.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _createAppBAr(movie),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(height: 10),
          _posterTitle(context, movie),
          _movieDescription(movie),
          _movieDescription(movie),
          _createCasting(movie)
        ]))
      ],
    ));
  }
}

Widget _createAppBAr(Movie movie) {
  return SliverAppBar(
    elevation: 2,
    backgroundColor: Colors.indigoAccent,
    floating: false,
    expandedHeight: 200,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        movie.title,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      background: FadeInImage(
        image: NetworkImage(
          movie.getBackgroundImg(),
        ),
        placeholder: AssetImage('assets/jar-loading.gif'),
        fadeInDuration: Duration(milliseconds: 15),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _posterTitle(BuildContext context, Movie movie) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Hero(
          tag: movie.id,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                  image: NetworkImage(movie.getPosterImg()), height: 150)),
        ),
        SizedBox(width: 20),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(movie.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis),
            Text(movie.originalTitle,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis),
            Row(
              children: [
                Icon(Icons.star_border),
                Text(
                  movie.voteAverage.toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                )
              ],
            )
          ],
        ))
      ],
    ),
  );
}

Widget _movieDescription(Movie movie) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Text(movie.overview, textAlign: TextAlign.justify),
  );
}

Widget _createCasting(Movie movie) {
  return FutureBuilder(
      future: actorBloc.fetchActors(movie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createActorPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
}

Widget _createActorPageView(List<Actor> actors) {
  return SizedBox(
    height: 200,
    child: PageView.builder(
        itemCount: actors.length,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemBuilder: (context, i) => _actorCard(actors[i])),
  );
}

Widget _actorCard(Actor actor) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(actor.getPhoto()),
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ),
  );
}
