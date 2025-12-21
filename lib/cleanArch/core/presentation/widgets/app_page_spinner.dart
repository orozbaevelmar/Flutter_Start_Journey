import 'package:flutter/material.dart';
import 'package:start_journey/cleanArch/core/extensions/context_extension.dart';
import 'package:start_journey/cleanArch/core/theme/images.dart';

class AppPageSpinner extends StatefulWidget {
  const AppPageSpinner({super.key, this.useOverlay = false});

  final bool useOverlay;

  @override
  AppPageSpinnerState createState() => AppPageSpinnerState();
}

class AppPageSpinnerState extends State<AppPageSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.startJourneyTheme;
    Widget spinner = SizedBox(
      height: appTheme.scaledSize(106),
      width: appTheme.scaledSize(106),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: RotationTransition(
              turns: _animation,
              child: Image.asset(
                Images.youtube,
                height: appTheme.scaledSize(100),
                width: appTheme.scaledSize(100),
              ),
            ),
          ),
        ],
      ),
    );

    if (widget.useOverlay) {
      return IgnorePointer(
        ignoring: true,
        child: ColoredBox(
          color: Colors.white.withOpacity(0.7),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(child: spinner),
          ),
        ),
      );
    }

    return spinner;
  }
}
