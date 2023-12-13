import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:start_journey/main_screen/welcome_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.grey.shade100,
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
