import 'package:miscellanous/domain/domain.dart';

import '../models/pokeApi_pokemon_response.dart';

class PokemonMapper {
  static Pokemon pokeApiPokemonToEntity(Map<String, dynamic> json) {
    final pokeApiPokemon = PokeApiPokemonResponse.fromJson(json);

    return Pokemon(
        id: pokeApiPokemon.id,
        name: pokeApiPokemon.name,
        url: pokeApiPokemon.sprites.frontDefault);
  }
}
