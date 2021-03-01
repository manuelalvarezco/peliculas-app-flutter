import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SiperCardWidget extends StatelessWidget {
  final BuildContext context;
  final AsyncSnapshot snapshot;

  SiperCardWidget({@required this.context, @required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}'),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: snapshot.data.results.length,
        layout: SwiperLayout.STACK,
        itemHeight: _screenSize.height * 0.5,
        itemWidth: _screenSize.width * 0.7,
      ),
    );
  }
}
