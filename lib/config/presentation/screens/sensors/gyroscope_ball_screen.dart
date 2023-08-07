import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope$ = ref.watch(gyroscopeProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Gyroscope Ball'),
        ),
        body: SizedBox.expand(
            child: gyroscope$.when(
                data: (value) => const Text('values'),
                error: (s, e) => Text('Error: $e'),
                loading: () => const CircularProgressIndicator())));
  }
}

class MovingBall extends StatelessWidget {
  final double x;
  final double y;
  const MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double screenWidth = size.width;
    double screenHeight = size.height;

    double currentYPosition = y * 100;
    double currentXPosition = x * 100;

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 100),
          left: (currentYPosition - 25) + (screenWidth / 2),
          top: (currentXPosition - 25) + (screenHeight / 2),
          child: const Ball(),
        ),
        Text('x: $x, y: $y', style: const TextStyle(fontSize: 30))
      ],
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(100))),
    );
  }
}
