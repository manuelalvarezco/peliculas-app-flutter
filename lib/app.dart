import 'package:flutter/material.dart';
import 'package:peliculasapp/Movies/ui/movie_list_page.dart';
import 'package:peliculasapp/Movies/ui/movie_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => MovieListPage(),
        'movie': (BuildContext context) => MoviePage()
      },
    );
  }
}
