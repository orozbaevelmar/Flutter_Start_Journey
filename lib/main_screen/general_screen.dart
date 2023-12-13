import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:start_journey/favourite/favourite_screen.dart';
import 'package:start_journey/home/home_screen.dart';
import 'package:start_journey/settings/settings_screen.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  int _selectedIndex = 2;

  static List<Widget> _widgetOptions = [
    Scaffold(),
    FavouriteScreen(),
    HomeScreen(),
    Scaffold(),
    Settings_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade100, // Colors.grey.shade200,
      /* appBar: AppBar(
        title: Text("Start Travel"),
        //backgroundColor: Color.fromRGBO(166, 202, 190, 0),
        actions: [HomeAppBar()],
      ), */
      /* drawer: Drawer(
        // Add a ListView to the drawer
        child: CallDrawer(),
      ), */

      // Body

      body: _widgetOptions.elementAt(_selectedIndex),

      // Bottom

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey.shade100,
        index: 2,
        items: const [
          Icon(Icons.person_outline, size: 30),
          Icon(Icons.favorite_outline_outlined, size: 30),
          Icon(Icons.home, size: 30, color: Colors.redAccent),
          Icon(Icons.location_on_outlined, size: 30),
          Icon(
            Icons.settings_outlined,
            size: 30,
          ),
        ],
        onTap: (int index) {
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }
}
