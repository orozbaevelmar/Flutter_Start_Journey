import 'package:flutter/material.dart';
import 'package:start_journey/cleanArch/core/extensions/context_extension.dart';
import 'package:start_journey/cleanArch/core/theme/app_color.dart';

enum ButtonVariant { primary, secondary }

class Button extends StatelessWidget {
  final String text;
  final ButtonVariant variant;
  final VoidCallback? onPressed;
  final bool isLoading;

  const Button(
    this.text, {
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.variant = ButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.startJourneyTheme;

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            overlayColor: AppColor.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(0, 40),
            disabledForegroundColor: AppColor.white,
            disabledBackgroundColor: AppColor.greenPrimary.withValues(
              alpha: 0.5,
            ),
            foregroundColor: AppColor.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            backgroundColor: AppColor.greenPrimary,
          ),
          child: Text(text, style: appTheme.LGStrong),
        );

      case ButtonVariant.secondary:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            side: BorderSide(color: AppColor.greenPrimary, width: 1.0),
          ),
          child: Text(
            text,
            style: appTheme.LGStrong.copyWith(
              color: AppColor.white,
            ),
          ),
        );
    }
  }
}
