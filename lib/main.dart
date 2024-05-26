import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/bloc/favorites/bloc.dart';
import 'package:start_journey/bloc/hotel/bloc.dart';
import 'package:start_journey/bloc/sights/bloc.dart';

import 'package:start_journey/u_presentation/screen/enter/welcome.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (c) => HotelBloc()),
        BlocProvider(create: (c) => SightsBloc()),
        BlocProvider(create: (c) => FavoritesBloc()),
      ],
      child: MaterialApp(
        color: Colors.grey.shade100,
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}
