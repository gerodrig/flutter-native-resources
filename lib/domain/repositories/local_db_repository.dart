import 'package:miscellanous/domain/domain.dart';

abstract class LocalDBRepository {
  Future<List<Pokemon>> loadPokemons();

  Future<int> pokemonCount();

  Future<void> insertPokemon(Pokemon pokemon);
}
