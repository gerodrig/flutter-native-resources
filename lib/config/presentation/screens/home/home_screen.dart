import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';
import 'package:miscellanous/config/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final adBannerAsync = ref.watch(adBannerProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text('Miscellaneous'),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          context.push('/settings');
                        },
                      ),
                    ],
                  ),
                  const MainMenu(),
                ],
              ),
            ),
          ),
          adBannerAsync.when(
            data: (ad) => SizedBox(
              width: ad.size.width.toDouble(),
              height: ad.size.height.toDouble(),
              child: AdWidget(ad: ad),
            ),
            loading: () => const SizedBox.shrink(),
            error: (e, s) => const SizedBox.shrink(),
          ),
        ],
      ),

      //Ad Banner
    );
  }
}
