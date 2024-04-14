import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:start_journey/account/account.dart';
import 'package:start_journey/favourite/favourite_screen.dart';
import 'package:start_journey/home/home_screen.dart';
import 'package:start_journey/settings/settings_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 2;

  final List<Widget> _widgetOptions = [
    AccountScreen(),
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
