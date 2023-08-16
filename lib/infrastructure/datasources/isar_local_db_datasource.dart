import 'package:isar/isar.dart';
import 'package:miscellanous/domain/domain.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalDBDatasource extends LocalDBDatasource {
  late Future<Isar> db;

  IsarLocalDBDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final directory = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      await Isar.open(
        [PokemonSchema],
        directory: directory.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    final isar = await db;

    isar.writeTxnSync(() => isar.pokemons.putSync(pokemon));
  }

  @override
  Future<List<Pokemon>> loadPokemons() async {
    final isar = await db;

    return isar.pokemons.where().findAll();
  }

  @override
  Future<int> pokemonCount() async {
    final isar = await db;

    return isar.pokemons.count();
  }
}
