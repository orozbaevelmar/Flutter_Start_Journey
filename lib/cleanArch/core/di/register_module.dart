import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_journey/cleanArch/app/app_config.dart';
import 'package:start_journey/cleanArch/core/constants/api_constants.dart';
import 'package:start_journey/cleanArch/core/di/injection.dart';
import 'package:start_journey/cleanArch/core/network/api_consumer.dart';
import 'package:start_journey/cleanArch/core/network/dio_consumer.dart';
import 'package:start_journey/cleanArch/core/network/interceptors/auth_interceptor.dart';
import 'package:start_journey/cleanArch/core/network/interceptors/unauth_interceptor.dart';

@module
abstract class RegisterModule {
  @factoryMethod
  Dio get dioClient => Dio();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @factoryMethod
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker.instance;

  @Named(ApiConstants.unAuthenticatedConsumer)
  @lazySingleton
  ApiConsumer get mainApiConsumer => DioConsumer(
        dioClient: getIt<Dio>(),
        appConfig: getIt<AppFlavorConfig>(),
        interceptor: getIt<UnAuthInterceptor>(),
      );

  @Named(ApiConstants.authenticatedConsumer)
  @lazySingleton
  ApiConsumer get authenticatedApiConsumer => DioConsumer(
        dioClient: getIt<Dio>(),
        appConfig: getIt<AppFlavorConfig>(),
        interceptor: getIt<AuthInterceptor>(),
      );
}
