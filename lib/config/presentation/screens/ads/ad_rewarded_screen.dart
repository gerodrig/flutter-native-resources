import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';

class AdRewardedScreen extends ConsumerWidget {
  const AdRewardedScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final adRewardedAsync = ref.watch(adRewardedProvider);
    final adPoints = ref.watch(adPointsProvider);

    ref.listen(adRewardedProvider, (previous, next) {
      if (!next.hasValue || next.value == null) return;

      next.value!.show(onUserEarnedReward: (ad, reward) {
        ref.read(adPointsProvider.notifier).update((state) => state + 10);
      });
    });

    if (adRewardedAsync.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Rewarded Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            //context is with router_go
            context.go('/');
          },
        ),
      ),
      body: Center(
        child: Text('Current points: $adPoints'),
      ),
    );
  }
}
