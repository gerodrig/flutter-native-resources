import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscellanous/domain/domain.dart';
import 'package:miscellanous/infrastructure/infrastructure.dart';

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonsRepositoryImpl();
});

final pokemonProvider = FutureProvider.family<Pokemon, String>((ref, id) async {
  final pokemonRepository = ref.watch(pokemonRepositoryProvider);
  final (pokemon, error) = await pokemonRepository.getPokemon(id);

  if (pokemon != null) return pokemon;

  throw Exception(error);
});
