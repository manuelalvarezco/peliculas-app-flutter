import 'dart:async';

import 'package:peliculasapp/Movies/models/actor_model.dart';
import 'package:peliculasapp/Movies/resources/actor_repository.dart';

class ActorBloc {
  final actorRepository = ActorRepository();

  List<Actor> _actors = [];

  final _actorStreamController = StreamController<List<Actor>>.broadcast();

  Function(List<Actor>) get actorsSink => _actorStreamController.sink.add;

  Stream<List<Actor>> get actorStream => _actorStreamController.stream;

  Future<List<Actor>> fetchActors(idMovie) async {
    List<Actor> actors = await actorRepository.fetchActor(idMovie);
    _actors.addAll(actors);
    actorsSink(_actors);

    return actors;
  }

  dispose() {
    _actorStreamController.close();
  }
}

final actorBloc = ActorBloc();
