import 'package:flutter/material.dart';
import 'package:start_journey/cleanArch/core/extensions/context_extension.dart';
import 'package:start_journey/cleanArch/core/constants/app_constants1.dart';

class AuthBackgroundGradient extends StatelessWidget {
  final Widget child;
  final AppBar? appBar;
  final Widget? bottomBar;

  const AuthBackgroundGradient({
    super.key,
    required this.child,
    this.appBar,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.startJourneyTheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: AppColor.primaryGradientColor),
        child: Padding(
          padding: EdgeInsets.only(
            left: appTheme.paddingM,
            right: appTheme.paddingM,
          ),
          child: child,
        ),
      ),
    );
  }
}
