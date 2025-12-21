import 'package:flutter/material.dart';
import 'package:start_journey/cleanArch/core/constants/app_constants1.dart';
import 'package:start_journey/cleanArch/features/bottom_nav_bar/screens/navigation_bar.dart';
import 'package:start_journey/cleanArch/core/constants/app_constants1.dart';
import 'package:start_journey/cleanArch/core/extensions/context_extension.dart';
import 'package:start_journey/cleanArch/features/bottom_nav_bar/screens/navigation_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.startJourneyTheme;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/nature.jpg'),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 65),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Start Journey",
                  style: appTheme.cardLabel.copyWith(
                    fontSize: 35,
                    letterSpacing: appTheme.scaledSize(2.0),
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () => Go.to(context, const NavigationBarScreen()),
                  child: Ink(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.black54,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
