import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:start_journey/model/favorites.dart';
import 'package:start_journey/model/hotel.dart';
import 'package:start_journey/repository/response_body/response_body_hotel.dart';
import 'package:start_journey/repository/response_body/response_body_sights.dart';
import 'package:start_journey/utils/constants/m_strings.dart';
import 'package:start_journey/utils/dependency_injection.dart';
import 'package:start_journey/utils/failure.dart';
import 'package:start_journey/utils/locale_secure_storage.dart';

class FavoritesRepository {
  static Future<Either<Failure, HotelsModel>> getFavoritesVisualisation(
      {required String url}) async {
    try {
      final String responseBody = url;
      if (4 > 3 /* response.statusCode == 200 */) {
        //print('abf');
        return Right(HotelsModel.fromJson(responseBody));
      } else {
        return Left(Failure(message: 'Failed to parse json response'));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }

  static Future<bool> deleteFavoritesVisualisationHotel(int hotelId) async {
    return HowLooksFetchedDataHotel().setFalseFavoriteIcon(hotelId);
  }

  static Future<bool> postFavoritesVisualisationHotel(int hotelId) async {
    return HowLooksFetchedDataHotel().setTrueFavoriteIcon(hotelId);
  }

  static Future<bool> deleteFavoritesVisualisationSights(int sightsId) async {
    return HowLooksFetchedDataSights().setFalseFavoriteIcon(sightsId);
  }

  static Future<bool> postFavoritesVisualisationSights(int sightsId) async {
    return HowLooksFetchedDataSights().setTrueFavoriteIcon(sightsId);
  }
}

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

class FavoritesRepositoryInReality {
  static Future<Either<Failure, FavoritesModel>> getFavoritesInReality(
      {required String url}) async {
    try {
      var uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          'Authorization':
              'token ${getIt<LocaleSecureStorage>().getSecureToken()}'
        },
      );

      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        var json = jsonDecode(responseBody);
        FavoritesModel favoritesModel = FavoritesModel.fromJson(json);
        return Right(favoritesModel);
      } else {
        return Left(Failure(message: 'Failed to parse json response'));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }

  static Future<bool> deleteFavoritesInReality(int hotelId) async {
    final response = await http
        .delete(Uri.parse("${MString.BASE_URL}/favorites/$hotelId/"), headers: {
      'Authorization': 'token ${getIt<LocaleSecureStorage>().getSecureToken()}'
    });

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  static Future<bool> postFavoritesInReality(int hotelId) async {
    final response = await http.post(
      Uri.parse("${MString.BASE_URL}/favorites/"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'token ${getIt<LocaleSecureStorage>().getSecureToken()}'
      },
      body: jsonEncode(<String, int>{
        "hotel_id": hotelId,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
