import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';

class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final magnetometer$ = ref.watch(magnetometerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Magnetometer'),
      ),
      body: Center(
          child: magnetometer$.when(
              data: (value) => Text(value.x.toString(),
                  style: const TextStyle(fontSize: 30)),
              error: (e, s) => Text('Error: $e'),
              loading: () => const CircularProgressIndicator())),
    );
  }
}
