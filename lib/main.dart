import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/firebase_options.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/presentation/bloc/hotel/hotel_bloc.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/enter/welcome.dart';
import 'package:start_journey/moveToCleanArch/core/di/dependency_injection.dart'
    as get_it;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await get_it.setupDependencies();
  await get_it.getIt.allReady();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //     create: (c) => AuthBloc(
        //         userSignUp: UserSignUp(
        //             AuthRepositoryImpl(AuthRemoteDataSourceImpl(Dio()))))),
        BlocProvider(create: (c) => get_it.getIt<HotelBloc>()),
        //BlocProvider(create: (c) => SightsBloc()),
        //BlocProvider(create: (c) => FavoritesBloc()),
      ],
      child: MaterialApp(
        color: Colors.grey.shade100,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
