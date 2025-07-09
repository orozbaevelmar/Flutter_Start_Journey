import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/moveToCleanArch/core/di/dependency_injection.dart';
import 'package:start_journey/moveToCleanArch/features/auth/data/datasources/auth_remote_data_source.dart';

import 'package:start_journey/moveToCleanArch/features/auth/data/repositories/auth_repository_impl.dart';

import 'package:start_journey/moveToCleanArch/features/auth/domain/usecases/user_sign_up.dart';
import 'package:start_journey/moveToCleanArch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:start_journey/old_stuffs/bloc/favorites/bloc.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/presentation/bloc/hotel/hotel_bloc.dart';
import 'package:start_journey/old_stuffs/bloc/sights/bloc.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/enter/welcome.dart';
import 'package:start_journey/old_stuffs/utils/dependency_injection.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

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
        BlocProvider(create: (c) => getIt<HotelBloc>()),
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
