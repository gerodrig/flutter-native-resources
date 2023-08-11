import 'package:miscellanous/domain/entities/pokemon.dart';

abstract class PokemonsDataSource {
  Future<(Pokemon?, String)> getPokemon(String id);
}
