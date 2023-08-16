import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscellanous/domain/domain.dart';
import 'package:miscellanous/infrastructure/infrastructure.dart';

final pokemonDBProvider =
    FutureProvider.autoDispose<List<Pokemon>>((ref) async {
  final localDB = LocalDBRepositoryImpl();
  final pokemons = await localDB.loadPokemons();

  return pokemons;
});
