import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerXYZ {
  final double x;
  final double y;
  final double z;

  AccelerometerXYZ(
    this.x,
    this.y,
    this.z,
  );

  @override
  String toString() {
    return 'x: $x, y: $y, z: $z';
  }
}

final accelerometerGravityProvider =
    StreamProvider<AccelerometerXYZ>((ref) async* {
  await for (final event in gyroscopeEvents) {
    final x = double.parse((event.x).toStringAsFixed(2));
    final y = double.parse((event.x).toStringAsFixed(2));
    final z = double.parse((event.x).toStringAsFixed(2));

    yield AccelerometerXYZ(x, y, z);
  }
});

final accelerometerUserProvider =
    StreamProvider<AccelerometerXYZ>((ref) async* {
  await for (final event in userAccelerometerEvents) {
    final x = double.parse((event.x).toStringAsFixed(2));
    final y = double.parse((event.x).toStringAsFixed(2));
    final z = double.parse((event.x).toStringAsFixed(2));

    yield AccelerometerXYZ(x, y, z);
  }
});
