import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';

class AdFullScreen extends ConsumerWidget {
  const AdFullScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final interstitialAdAsync = ref.watch(adInterstitialProvider);

    //listen to the ad
    ref.listen(adInterstitialProvider, (previous, next) {
      if (!next.hasValue || next.value == null) return;

      next.value!.show();
    });

    if (interstitialAdAsync.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (interstitialAdAsync.hasValue) {
      interstitialAdAsync.value!.show();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Full Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            //context is with router_go
            context.go('/');
          },
        ),
      ),
      body: const Center(
        child: Text('You can return or see this screen'),
      ),
    );
  }
}
