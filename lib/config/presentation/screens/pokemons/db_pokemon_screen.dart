import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscellanous/config/presentation/providers/background_tasks/background_tasks_provider.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';
import 'package:miscellanous/config/workmanager/callback_dispatcher.dart';
import 'package:miscellanous/domain/domain.dart';
import 'package:workmanager/workmanager.dart';

class DBPokemonsScreen extends ConsumerWidget {
  const DBPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonsAsync = ref.watch(pokemonDBProvider);
    final isBackgroundFetchActive = ref.watch(backgroundPokemonFetchProvider);

    if (pokemonsAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final List<Pokemon> pokemons = pokemonsAsync.value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Process'),
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          //TODO: Create the action
          IconButton(
              onPressed: () {
                Workmanager().registerOneOffTask(
                  fetchBackgroundTaskKey,
                  fetchBackgroundTaskKey,
                  initialDelay: const Duration(seconds: 3),
                  inputData: {'howMany': 10, 'offset': 0},
                  constraints: Constraints(networkType: NetworkType.connected),
                );
              },
              icon: const Icon(Icons.add_alarm_sharp))
        ],
      ),
      body: CustomScrollView(
        slivers: [_PokemonsGrid(pokemons: pokemons)],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //* Activate or deactivate the background process
          ref.read(backgroundPokemonFetchProvider.notifier).toggleProcess();
        },
        label: (isBackgroundFetchActive == true)
            ? const Text('Deactivate periodic fetch')
            : const Text('Activate periodic fetch'),
        icon: const Icon(Icons.av_timer_sharp),
      ),
    );
  }
}

class _PokemonsGrid extends StatelessWidget {
  final List<Pokemon> pokemons;
  const _PokemonsGrid({required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return Card(
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  pokemon.url,
                  fit: BoxFit.contain,
                ),
              ),
              Text(pokemon.name),
            ],
          ),
        );
      },
    );
  }
}
