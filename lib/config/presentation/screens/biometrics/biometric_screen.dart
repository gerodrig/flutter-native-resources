import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch(localAuthProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.go('/')),
        title: const Text('Biometric'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton.tonal(
              onPressed: () {
                ref.read(localAuthProvider.notifier).authenticateUser();
              },
              child: const Text('Authenticate')),

          // process Feedback
          canCheckBiometrics.when(
            data: (canCheckBiometrics) =>
                Text('Can check biometrics: $canCheckBiometrics'),
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text('Error: $error'),
          ),

          const SizedBox(height: 40),
          const Text('Biometric state', style: TextStyle(fontSize: 30)),
          Text('State $localAuthState', style: const TextStyle(fontSize: 14)),
        ],
      )),
    );
  }
}
