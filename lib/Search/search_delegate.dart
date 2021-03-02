import 'package:flutter/material.dart';
import 'package:peliculasapp/Movies/models/movie_popular.dart';
import 'package:peliculasapp/Search/resources/search_api_provider.dart';

class DataSearch extends SearchDelegate {
  final searchApiProvider = SearchApiProvider();
  String selection = '';
  final movies = [
    'Superman',
    'Hulk',
    'La mujer maravilla',
    'El hombre sapo',
    'Yoyo',
  ];

  final recentMovies = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro appBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izq del AppBar
    return IconButton(
        icon: AnimatedIcon(
            progress: transitionAnimation, icon: AnimatedIcons.menu_arrow),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: searchApiProvider.searchMovies(query),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
              children: peliculas.map((pelicula) {
            return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle));
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  oldSuggestion() {
    final suggestList = (query.isEmpty)
        ? recentMovies
        : movies
            .where(
                (movie) => movie.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    // Sugerencias
    return ListView.builder(
      itemCount: suggestList.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestList[i]),
          onTap: () {
            selection = suggestList[i];
            showResults(context);
          },
        );
      },
    );
  }
}
