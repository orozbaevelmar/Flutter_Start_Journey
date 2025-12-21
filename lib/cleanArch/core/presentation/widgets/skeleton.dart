import 'package:flutter/material.dart';
import 'package:start_journey/cleanArch/core/extensions/context_extension.dart';
import 'package:start_journey/cleanArch/core/presentation/widgets/separator.dart';
import 'package:start_journey/cleanArch/core/constants/app_constants1.dart';

class Skeleton extends StatefulWidget {
  final double height;
  final double width;
  final Widget? startIcon;
  final Widget? endIcon;
  final Radius borderRadius;

  const Skeleton({
    super.key,
    this.height = 28,
    this.width = 80,
    this.startIcon,
    this.endIcon,
    this.borderRadius = const Radius.circular(8),
  });

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.startJourneyTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.startIcon != null) ...[
          widget.startIcon!,
          Separator.forRow(appTheme.scaledSize(8)),
        ],
        SizedBox(
          height: widget.height,
          width: widget.width - 24,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, state) {
              return ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [
                      AppColor.black.withAlpha(15),
                      AppColor.black.withAlpha(5),
                      AppColor.black.withAlpha(15),
                    ],
                    stops: [
                      (_controller.value - 0.3).clamp(0.0, 1.0),
                      (_controller.value).clamp(0.0, 1.0),
                      (_controller.value + 0.3).clamp(0.0, 1.0),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.all(widget.borderRadius),
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.endIcon != null) ...[
          Separator.forRow(appTheme.scaledSize(8)),
          widget.endIcon!,
        ],
      ],
    );
  }
}
