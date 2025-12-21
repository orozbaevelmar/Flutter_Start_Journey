// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../app/app_config.dart' as _i861;
import '../../features/auth/data/datasources/firebase_auth_remote_data_sources.dart'
    as _i88;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/hotel/data/datasources/hotel_remote_data_source.dart'
    as _i220;
import '../../features/hotel/data/repositories/places_repository_impl.dart'
    as _i410;
import '../../features/hotel/domain/repositories/places_repository.dart'
    as _i395;
import '../../features/hotel/domain/usecases/get_all_hotels.dart' as _i486;
import '../../features/hotel/presentation/bloc/hotel/hotel_bloc.dart' as _i667;
import '../network/api_consumer.dart' as _i931;
import '../network/interceptors/auth_interceptor.dart' as _i745;
import '../network/interceptors/unauth_interceptor.dart' as _i1000;
import '../network/netowrk_info/network_info.dart' as _i24;
import '../services/token_service.dart' as _i227;
import '../utils/snackbar_service.dart' as _i304;
import 'register_module.dart' as _i291;

const String _dev = 'dev';
const String _prod = 'prod';

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i361.Dio>(() => registerModule.dioClient);
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i973.InternetConnectionChecker>(
      () => registerModule.connectionChecker);
  gh.lazySingleton<_i1000.UnAuthInterceptor>(() => _i1000.UnAuthInterceptor());
  gh.lazySingleton<_i304.SnackBarService>(() => _i304.SnackBarService());
  gh.lazySingleton<_i931.ApiConsumer>(
    () => registerModule.authenticatedApiConsumer,
    instanceName: 'authenticatedConsumer',
  );
  gh.lazySingleton<_i227.TokenService>(
      () => _i227.TokenService(gh<_i460.SharedPreferences>()));
  gh.factory<_i861.AppFlavorConfig>(
    () => _i861.FlavorConfigDev(),
    registerFor: {_dev},
  );
  gh.lazySingleton<_i931.ApiConsumer>(
    () => registerModule.mainApiConsumer,
    instanceName: 'unAuthenticatedConsumer',
  );
  gh.lazySingleton<_i745.AuthInterceptor>(() => _i745.AuthInterceptor(
        gh<_i227.TokenService>(),
        gh<_i787.AuthRepository>(),
      ));
  gh.factory<_i861.AppFlavorConfig>(
    () => _i861.FlavorConfigProd(),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i220.HotelRemoteDataSource>(
      () => _i220.HotelRemoteDataSourceImpl(dio: gh<_i361.Dio>()));
  gh.lazySingleton<_i88.AuthRemoteDataSource>(() =>
      _i88.AuthRemoteDataSourceImpl(firebaseAuth: gh<_i59.FirebaseAuth>()));
  gh.lazySingleton<_i24.NetworkInfo>(
      () => _i24.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
  gh.factory<_i395.PlacesRepository>(() => _i410.HotelRepositoryImpl(
      remoteDataSource: gh<_i220.HotelRemoteDataSource>()));
  gh.lazySingleton<_i486.GetHotelsUseCase>(
      () => _i486.GetHotelsUseCase(gh<_i395.PlacesRepository>()));
  gh.factory<_i667.HotelBloc>(
      () => _i667.HotelBloc(getHotelsUsecase: gh<_i486.GetHotelsUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i291.RegisterModule {}
