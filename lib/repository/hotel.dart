import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:start_journey/model/hotel.dart';
import 'package:start_journey/model/response_body/response_body.dart';
import 'package:start_journey/utils/dependency_injection.dart';
import 'package:start_journey/utils/failure.dart';
import 'package:http/http.dart' as http;
import 'package:start_journey/utils/locale_secure_storage.dart';

class HotelRepository {
  static Future<Either<Failure, HotelsModel>> getHotels(
      {required String url}) async {
    try {
      final response = HowLooksFetchedData.fetchedResponseBody;

      if (4 > 3 /* response.statusCode == 200 */) {
        //String responseBody = utf8.decode(response.bodyBytes);
        return Right(HotelsModel.fromJson(response));
      } else {
        return Left(Failure(message: 'Failed to parse json response'));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }

  static Future<Either<Failure, HotelsModel>> showVisualisation(
      {required String url}) async {
    try {
      var uri = Uri.parse(url);
      var headers = {
        'Authorithation':
            'token ${getIt.get<LocaleSecureStorage>().getSecureToken()}'
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        return Right(HotelsModel.fromJson(responseBody));
      } else {
        return Left(Failure(message: 'Failed to parse json response'));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }
}
