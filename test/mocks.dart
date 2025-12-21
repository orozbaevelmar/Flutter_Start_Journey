import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_journey/cleanArch/core/network/dio_consumer.dart';
import 'package:start_journey/cleanArch/core/services/token_service.dart';
import 'package:start_journey/cleanArch/features/auth/data/datasources/firebase_auth_remote_data_sources.dart';

import 'package:start_journey/cleanArch/features/auth/domain/repositories/auth_repository.dart';

// Generate mocks for all dependencies
@GenerateMocks([
  Dio,
  SharedPreferences,
  TokenService,
  DioConsumer,
  AuthRepository,
  AuthRemoteDataSource,
])
void main() {}
