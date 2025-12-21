import 'package:flutter/material.dart';
import 'package:start_journey/cleanArch/core/extensions/context_extension.dart';

class AppSpinner extends StatefulWidget {
  final double? size;
  final Color? color;

  const AppSpinner({super.key, this.size, this.color});

  @override
  AppSpinnerState createState() => AppSpinnerState();
}

class AppSpinnerState extends State<AppSpinner>
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
    final spinnerSize = widget.size ?? appTheme.scaledSize(24);
    return Center(
      child: SizedBox(
        width: spinnerSize,
        height: spinnerSize,
        child: RotationTransition(
          turns: _animation,
          child: Image.asset(
            'assets/app/spinner.png',
            color: widget.color,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
