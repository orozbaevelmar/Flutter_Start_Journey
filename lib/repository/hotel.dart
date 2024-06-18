import 'package:dartz/dartz.dart';
import 'package:start_journey/model/hotel.dart';
import 'package:start_journey/utils/failure.dart';

class HotelRepository {
  static Future<Either<Failure, HotelsModel>> getHotelsVisualisation(
      {required String url}) async {
    try {
      final String responseBody = url;

      if (4 > 3 /* response.statusCode == 200 */) {
        return Right(HotelsModel.fromJson(responseBody));
      } else {
        return Left(Failure(message: 'Failed to parse json response'));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong'));
    }
  }
}
