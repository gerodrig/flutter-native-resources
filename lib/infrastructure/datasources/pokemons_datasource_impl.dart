import 'package:dio/dio.dart';
import 'package:miscellanous/domain/domain.dart';
import 'package:miscellanous/infrastructure/mappers/pokemon_mapper.dart';

class PokemonsDatasourceImpl implements PokemonsDataSource {
  final Dio dio;

  PokemonsDatasourceImpl()
      : dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));
  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {
      final response = await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.pokeApiPokemonToEntity(response.data);

      return (pokemon, 'Data fetched successfully');
    } catch (e) {
      return (null, 'Pokemon not found $e');
    }
  }
}
