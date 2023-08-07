import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:miscellanous/config/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
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
    ));
  }
}
