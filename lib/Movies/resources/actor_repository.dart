import 'package:peliculasapp/Movies/models/actor_model.dart';
import 'package:peliculasapp/Movies/resources/actor_api_provider.dart';

class ActorRepository {
  final actorApiProvider = ActorApiProvider();

  Future<List<Actor>> fetchActor(idMovie) => actorApiProvider.getCast(idMovie);
}
