import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/data/datasources/hotel_remote_data_source.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/data/repositories/places_repository_impl.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/domain/repositories/places_repository.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/domain/usecases/get_all_hotels.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/presentation/bloc/hotel/hotel_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Hotels
  _setupHotelDependencies();
}

void _setupHotelDependencies() {
  // Data Sources
  getIt.registerLazySingleton<HotelRemoteDataSource>(
    () => HotelRemoteDataSourceImpl(dio: Dio()),
  );

  // Repositories
  getIt.registerLazySingleton<PlacesRepository>(
    () => HotelRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetHotelsUseCase(getIt()));

  // BLoC is registered as factory to be disposable
  getIt.registerFactory(
    () => HotelBloc(getHotelsUsecase: getIt()),
  );
}
