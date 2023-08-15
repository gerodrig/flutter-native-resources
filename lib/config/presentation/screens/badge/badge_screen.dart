import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscellanous/config/config.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';

class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final badgeCounter = ref.watch(badgeCounterProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Badge'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Badge(
                  alignment: Alignment.lerp(
                      Alignment.topRight, Alignment.bottomRight, 0.2),
                  label: Text('$badgeCounter'),
                  child: Text('$badgeCounter',
                      style: const TextStyle(fontSize: 150))),
              FilledButton.tonal(
                  onPressed: () {
                    ref.invalidate(badgeCounterProvider);
                    AppBadgePlugin.removeBadge();
                  },
                  child: const Text('Delete Badge')),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref
                .read(badgeCounterProvider.notifier)
                .update((state) => state + 1);

            AppBadgePlugin.updateBadgeCount(badgeCounter + 1);
          },
          child: const Icon(Icons.plus_one),
        ));
  }
}
