import 'package:miscellanous/infrastructure/infrastructure.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey =
    'com.gerar.ca.miscellaneous.fetch-background-pokemon';
const fetchPeriodicBackgroundTaskKey =
    'com.gerar.ca.miscellaneous.fetch-periodic-background-pokemon';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroundTaskKey:
        await loadNextPokemon();
        break;
      case fetchPeriodicBackgroundTaskKey:
        await loadNextPokemon();
        break;
      case Workmanager.iOSBackgroundTask:
        print('iOSBackgroundTask');
        break;
    }

    return Future.value(true);
  });
}

Future loadNextPokemon() async {
  final localDBRepository = LocalDBRepositoryImpl();
  final pokemonRepository = PokemonsRepositoryImpl();

  final lastPokemonId = await localDBRepository.pokemonCount() + 1;

  try {
    final (pokemon, message) =
        await pokemonRepository.getPokemon('$lastPokemonId');

    if (pokemon == null) throw message;

    await localDBRepository.insertPokemon(pokemon);
    print('Pokemon ${pokemon.name} loaded successfully');
  } catch (e) {
    print(e);
  }
}
