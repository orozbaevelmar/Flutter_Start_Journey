import 'package:flutter/material.dart';
import 'dart:math';

import 'package:start_journey/cleanArch/core/theme/app_color.dart';

class RotatingLogoLoader extends StatefulWidget {
  final double size;

  const RotatingLogoLoader({super.key, this.size = 20});

  @override
  State<RotatingLogoLoader> createState() => _RotatingLogoLoaderState();
}

class _RotatingLogoLoaderState extends State<RotatingLogoLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _outerRotation;
  late Animation<double> _innerRotation;
  late Animation<double> _innerScale;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _innerScale = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _outerRotation = Tween<double>(
      begin: 0,
      end: -2 * pi / 3,
    ).animate(_animationController);

    _innerRotation = Tween<double>(
      begin: 0,
      end: 2 * pi / 3,
    ).animate(_animationController);

    _startLoop(); // Start endless loop with pause
  }

  void _startLoop() async {
    while (mounted) {
      await _animationController.forward();
      if (!mounted) break;
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) break;
      await _animationController.reverse();
      if (!mounted) break;
      await Future.delayed(const Duration(milliseconds: 600));
    }
  }

  @override
  void dispose() {
    // Stop the animation and dispose of the controller
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * 1.1,
      height: widget.size * 1.2,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: _outerRotation.value,
                child: SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColor.black,
                      shape: BoxShape.circle,
                    ),
                    child: CustomPaint(painter: TriangleOuterPainter()),
                  ),
                ),
              ),
              Transform.rotate(
                angle: _innerRotation.value,
                child: Transform.scale(
                  scale: _innerScale.value,
                  child: SizedBox(
                    width: widget.size * .7,
                    height: widget.size * .7,
                    child: CustomPaint(painter: TriangleInnerPainter()),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Path createRoundedTriangle(Size size, double radius) {
  final center = Offset(size.width / 2, size.height / 2);
  final r = size.width / 2;
  final points = List.generate(3, (i) {
    final angle = -pi / 2 + i * 2 * pi / 3;
    return Offset(center.dx + r * cos(angle), center.dy + r * sin(angle));
  });

  final path = Path();

  for (int i = 0; i < 3; i++) {
    final p1 = points[i];
    final p2 = points[(i + 1) % 3];
    final p0 = points[(i + 2) % 3];

    // Vector from p1 to p0 and p2
    final v1 = (p0 - p1).normalize();
    final v2 = (p2 - p1).normalize();

    final offset1 = p1 + v1 * radius;
    final offset2 = p1 + v2 * radius;

    if (i == 0) {
      path.moveTo(offset1.dx, offset1.dy);
    } else {
      path.lineTo(offset1.dx, offset1.dy);
    }

    path.quadraticBezierTo(p1.dx, p1.dy, offset2.dx, offset2.dy);
  }

  path.close();
  return path;
}

extension on Offset {
  Offset normalize() {
    final len = distance;
    return Offset(dx / len, dy / len);
  }
}

class TriangleOuterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = createRoundedTriangle(size, 8); // adjust radius
    final paint = Paint()..color = Colors.white;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TriangleInnerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = createRoundedTriangle(size, 6); // slightly smaller radius
    final paint = Paint()..color = AppColor.black;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
