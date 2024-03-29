import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:miscellanous/config/presentation/providers/providers.dart';

import 'package:miscellanous/config/presentation/screens/screens.dart';

// import 'dart:math' show pi;

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationGranted = ref.watch(permissionsProvider).locationGranted;
    final compassHeading$ = ref.watch(compassProvider);

    if (!locationGranted) {
      return const AskLocationScreen();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //include return button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            //context is with router_go
            context.go('/');
          },
        ),
        title: const Text('Compass', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
          child: compassHeading$.when(
              data: (heading) => Compass(heading: heading ?? 0),
              error: (e, s) => Text('Error $e'),
              loading: () => const CircularProgressIndicator())),
    );
  }
}

class Compass extends StatefulWidget {
  final double heading;
  const Compass({super.key, required this.heading});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double prevValue = 0.0;
  double turns = 0;

  double getTurns() {
    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction) : direction;

    double diff = direction - prevValue;
    if (diff.abs() > 180) {
      diff = (diff < 0) ? (360 + diff) : (diff - 360);
    }

    turns = turns + (diff / 360);
    prevValue = direction;

    return turns;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${widget.heading.ceil()}',
            style: const TextStyle(color: Colors.white, fontSize: 30)),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            // Image.asset('assets/images/compass/quadrant-1.png'),
            // Transform.rotate(
            //     angle: (heading * (pi / 180) * -1),
            //     child: Image.asset('assets/images/compass/needle-1.png')),

            // AnimatedRotation(
            //     curve: Curves.easeOut,
            //     turns: getTurns(),
            //     duration: const Duration(seconds: 1),
            //     child: Image.asset('assets/images/compass/needle-2.png'))
            AnimatedRotation(
                curve: Curves.easeOut,
                turns: getTurns(),
                duration: const Duration(seconds: 1),
                child: Image.asset('assets/images/compass/quadrant-1.png')),

            Image.asset('assets/images/compass/needle-1.png'),
          ],
        )
      ],
    );
  }
}
