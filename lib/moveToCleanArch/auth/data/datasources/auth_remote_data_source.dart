import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:start_journey/moveToCleanArch/core/error/exceptions.dart';
import 'package:start_journey/moveToCleanArch/core/constants/m_strings.dart';
import 'package:start_journey/old_stuffs/utils/dependency_injection.dart';
import 'package:start_journey/old_stuffs/utils/locale_secure_storage.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<String> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('${MString.BASE_URL}/auth/login/'),
        body: {
          'eimal': email,
          'password': password,
        },
      );

      final responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        // await getIt
        //     .get<LocaleSecureStorage>()
        //     .saveSecureToken(json.decode(responseBody)['token']);

        return '';
      } else {
        if (json.decode(responseBody)['email'] != null) {
          return '${json.decode(responseBody)['email']}';
        } else if (json.decode(responseBody)['phone'] != null) {
          return '${json.decode(responseBody)['phone'][0]}';
        } else {
          return 'Произошла ошибка';
        }
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> signUpWithEmailPassword(
      {required String name, required String email, required String password}) {
    // TODO: implement signUpWithEmailPassword
    throw UnimplementedError();
  }
}

/* @override
  Future<PokemonModel> getPokemon({required PokemonParams params}) async {
    final response = await dio.get(
      'https://pokeapi.co/api/v2/pokemon/${params.id}',
      queryParameters: {
        'api_key': 'if you need',
      },
    );

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  } */
