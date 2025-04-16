import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:start_journey/u_presentation/screen/account/account.dart';
import 'package:start_journey/u_presentation/screen/favourite/favourite_screen.dart';
import 'package:start_journey/u_presentation/screen/home/home_screen.dart';
import 'package:start_journey/u_presentation/screen/map/map_screen.dart';

import 'package:start_journey/u_presentation/screen/settings/settings_screen.dart';
import 'package:start_journey/u_presentation/screen/trip_journal/trip_journal.dart';
import 'package:start_journey/utils/constants/constants.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MColor.greyBackGroundColor,
      // body
      body: _screens.elementAt(_selectedIndex),
      // bottom
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color: Colors.white,
        animationDuration: const Duration(milliseconds: 600),
        backgroundColor: MColor.greyBackGroundColor,
        items: const [
          Icon(Icons.book, size: _iconSize),
          Icon(Icons.favorite_outline_outlined, size: _iconSize),
          Icon(Icons.home_outlined, size: _iconSize),
          Icon(Icons.location_on_outlined, size: _iconSize),
          Icon(Icons.settings_outlined, size: _iconSize),
        ],
        onTap: (int tappedIndex) =>
            setState(() => _selectedIndex = tappedIndex),
      ),
    );
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    TripJournal(),
    FavouriteScreen(),
    HomeScreen(),
    MapScreen(),
    Settings_Screen(),
  ];
  static const double _iconSize = 30;
}
