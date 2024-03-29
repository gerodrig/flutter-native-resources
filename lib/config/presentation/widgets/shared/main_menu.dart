import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem(this.title, this.icon, this.route);
}

final menuItems = <MenuItem>[
  MenuItem('Gyroscope', Icons.downloading, '/gyroscope'),
  MenuItem('Accelerometer', Icons.speed, '/accelerometer'),
  MenuItem('Magnetometer', Icons.explore_outlined, '/magnetometer'),
  MenuItem('Gyroscope Ball', Icons.sports_baseball_outlined, '/gyroscope-ball'),
  MenuItem('Compass', Icons.explore, '/compass'),
  MenuItem('Pokemons', Icons.catching_pokemon, '/pokemons'),
  MenuItem('Background Process', Icons.storage_rounded, '/db-pokemons'),
  MenuItem('Biometric', Icons.fingerprint, '/biometric'),
  MenuItem('Location', Icons.pin_drop, '/location'),
  MenuItem('Maps', Icons.map_outlined, '/maps'),
  MenuItem('Controlled', Icons.gamepad_outlined, '/controlled-map'),
  MenuItem('Badge', Icons.notification_important, '/badge'),
  MenuItem('Ad Full', Icons.ad_units_rounded, '/ad-fullscreen'),
  MenuItem('Ad Reward', Icons.fort_sharp, '/ad-rewarded'),
];

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: menuItems
          .map((item) => HomeMenuItem(
                title: item.title,
                icon: item.icon,
                route: item.route,
              ))
          .toList(),
    );
  }
}

class HomeMenuItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;
  final List<Color> bgColors;

  const HomeMenuItem(
      {super.key,
      required this.title,
      required this.route,
      required this.icon,
      this.bgColors = const [Colors.lightBlue, Colors.blueAccent]});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: bgColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
