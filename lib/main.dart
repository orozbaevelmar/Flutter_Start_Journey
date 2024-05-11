import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:start_journey/presentation/screen/enter/welcome.dart';
import 'package:start_journey/utils/dependency_injection.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await configureDi();
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
