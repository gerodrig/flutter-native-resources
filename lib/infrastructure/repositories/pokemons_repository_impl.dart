import 'package:miscellanous/domain/domain.dart';
import 'package:miscellanous/infrastructure/datasources/pokemons_datasource_impl.dart';

class PokemonsRepositoryImpl implements PokemonRepository {
  final PokemonsDataSource datasource;

  PokemonsRepositoryImpl({PokemonsDataSource? datasource})
      : datasource = datasource ?? PokemonsDatasourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return await datasource.getPokemon(id);
  }
}
