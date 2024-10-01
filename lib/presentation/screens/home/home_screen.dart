import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Miscelaneos'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         context.push('/permissions');
      //       },
      //       icon: const Icon( Icons.settings )
      //     )
      //   ],
      // ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Miscelaneos'),
              actions: [
                IconButton(
                    onPressed: () {
                      context.push('/permissions');
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            MainMenu()
          ],
        ),
      ),
    );
  }
}
