import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class MenuItem {


  final String title;
  final IconData icon;
  final String route;

  MenuItem(this.title, this.icon, this.route);

}

  final menuItems = <MenuItem>[
    MenuItem('Giroscopio', Icons.downloading, '/gyroscope'),
    MenuItem('Acelerometer', Icons.speed, '/accelerometer'),
    MenuItem('Magnetometer', Icons.explore_outlined, '/magnetometer'),
    MenuItem('Brujula', Icons.sports_baseball_outlined, '/compass'),
    MenuItem('Giroscopio Ball', Icons.explore, '/gyroscope-ball'),
    MenuItem('Pokemons', Icons.catching_pokemon, '/pokemons'),
    MenuItem('Biometrics', Icons.fingerprint, '/biometrics'),


    MenuItem('Location', Icons.pin_drop, '/location'),
    MenuItem('Maps', Icons.map_outlined, '/maps'),
    MenuItem('Controlled', Icons.gamepad_outlined, '/controlled-map'),
  ];


class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: menuItems.map((item) => HomeMenuItem(
        title: item.title, 
        route: item.route, 
        icon: item.icon
      )).toList()
    );
  }
}


class HomeMenuItem extends StatelessWidget {

  final String title;
  final String route;
  final IconData icon;
  final List<Color> bgColors;

  const HomeMenuItem({
    super.key, 
    required this.title, 
    required this.route, 
    required this.icon, 
    this.bgColors = const [ Colors.lightBlue, Colors.blue]
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push( route ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: bgColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40,),
            const SizedBox( height: 10,),
            Text( title, textAlign: TextAlign.center, style: const TextStyle( fontSize: 10, color:  Colors.white),)
          ],
        ),
      ),
    );
  }
}