import 'package:flutter/material.dart';

class Go {
  static to(BuildContext context, destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  static back(BuildContext context) {
    Navigator.pop(context);
  }
}
