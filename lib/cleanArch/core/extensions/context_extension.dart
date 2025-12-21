import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_journey/cleanArch/core/theme/app_theme.dart';

extension ContextExtensions on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
  double get screenWidth => mq.size.width;
  double get screenHeight => mq.size.height;

  StartJourneyTheme get startJourneyTheme => read<StartJourneyTheme>();

  double getProportionateScreenHeight(double inputHeight) {
    final screenHeight = this.screenHeight;
    return (inputHeight / StartJourneyTheme.defaultScreenHeight) * screenHeight;
  }
}
