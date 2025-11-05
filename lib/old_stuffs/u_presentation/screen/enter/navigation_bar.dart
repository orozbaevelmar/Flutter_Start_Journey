import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/favourite/favourite_screen.dart';
import 'package:start_journey/moveToCleanArch/features/home/presentation/pages/home_screen.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/map/map_screen.dart';

import 'package:start_journey/old_stuffs/u_presentation/screen/settings/settings_screen.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/trip_journal/trip_journal.dart';
import 'package:start_journey/moveToCleanArch/core/constants/app_constants.dart';

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
      backgroundColor: AppColor.greyBackGroundColor,
      // body
      body: _screens.elementAt(_selectedIndex),
      // bottom
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color: Colors.white,
        animationDuration: const Duration(milliseconds: 600),
        backgroundColor: AppColor.greyBackGroundColor,
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
    //   FavouriteScreen(),
    Container(),
    HomeScreen(),
    MapScreen(),
    Settings_Screen(),
  ];
  static const double _iconSize = 30;
}
