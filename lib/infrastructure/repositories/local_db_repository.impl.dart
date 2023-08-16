import 'package:miscellanous/domain/domain.dart';
import 'package:miscellanous/infrastructure/datasources/isar_local_db_datasource.dart';

class LocalDBRepositoryImpl implements LocalDBRepository {
  final LocalDBDatasource _datasource;

  LocalDBRepositoryImpl([LocalDBDatasource? datasource])
      : _datasource = datasource ?? IsarLocalDBDatasource();

  @override
  Future<void> insertPokemon(Pokemon pokemon) {
    return _datasource.insertPokemon(pokemon);
  }

  @override
  Future<List<Pokemon>> loadPokemons() {
    return _datasource.loadPokemons();
  }

  @override
  Future<int> pokemonCount() {
    return _datasource.pokemonCount();
  }
}
