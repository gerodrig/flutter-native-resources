import 'package:go_router/go_router.dart';
import 'package:miscellanous/config/presentation/screens/screens.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => const PermissionsScreen(),
  ),
  GoRoute(
    path: '/gyroscope',
    builder: (context, state) => const GyroscopeScreen(),
  ),
  GoRoute(
    path: '/accelerometer',
    builder: (context, state) => const AccelerometerScreen(),
  ),
  GoRoute(
    path: '/gyroscope-ball',
    builder: (context, state) => const GyroscopeBallScreen(),
  ),
  GoRoute(
    path: '/compass',
    builder: (context, state) => const CompassScreen(),
  ),
  GoRoute(
    path: '/magnetometer',
    builder: (context, state) => const MagnetometerScreen(),
  ),
  GoRoute(
    path: '/biometric',
    builder: (context, state) => const BiometricScreen(),
  ),
  GoRoute(
    path: '/location',
    builder: (context, state) => const LocationScreen(),
  ),
  GoRoute(
    path: '/maps',
    builder: (context, state) => const MapScreen(),
  ),
  GoRoute(
    path: '/controlled-map',
    builder: (context, state) => const ControlledMapScreen(),
  ),
  GoRoute(
      path: '/pokemons',
      builder: (context, state) => const PokemonsScreen(),
      routes: [
        GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '1';
              return PokemonScreen(pokemonId: id);
            }),
      ]),
]);
