import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscellanous/config/presentation/providers/sensors/accelerometer_providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accelerometer$ = ref.watch(accelerometerGravityProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.go('/')),
        title: const Text('Accelerometer'),
      ),
      body: Center(
          child: accelerometer$.when(
              data: (value) =>
                  Text(value.toString(), style: const TextStyle(fontSize: 30)),
              error: ((e, s) => Text('Error: $e')),
              loading: () => const CircularProgressIndicator())),
    );
  }
}
