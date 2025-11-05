import 'package:flutter/material.dart';

class AppBoxShadow {
  static final regular = BoxShadow(
    blurRadius: 6,
    offset: Offset(0, 0),
    spreadRadius: 0.5,
    color: Colors.black.withValues(alpha: 0.1),
  );
}
