import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userLocationAsync = ref.watch(userLocationProvider);
    final watchLocationAsync = ref.watch(watchLocationProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.go('/')),
        title: const Text('Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //? Current Location
            const Text('Current Location'),
            userLocationAsync.when(
              data: (data) => Text(data.toString()),
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text(error.toString()),
            ),

            const SizedBox(height: 30),

            //? Current Location
            const Text('Location tracking'),
            watchLocationAsync.when(
              data: (data) => Text(data.toString()),
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text(error.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
