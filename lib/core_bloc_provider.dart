import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/cleanArch/core/di/injection.dart';
import 'package:start_journey/cleanArch/features/hotel/presentation/bloc/hotel/hotel_bloc.dart';

class CoreBlocProvider extends StatelessWidget {
  const CoreBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (c) => getIt<HotelBloc>()),
      ],
      child: child,
    );
  }
}
