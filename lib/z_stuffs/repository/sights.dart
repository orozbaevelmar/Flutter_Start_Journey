import 'package:dartz/dartz.dart';
import 'package:start_journey/z_stuffs/model/sights.dart';
import 'package:start_journey/z_stuffs/utils/failure.dart';

class SightsRepository {
  static Future<Either<Failure, SightsModel>> getSightsVisualisation(
      {required String url}) async {
    SightsModel.fromJson(url);
    try {
      final String responseBody = url;

      if (4 > 3 /* response.statusCode == 200 */) {
        return Right(SightsModel.fromJson(responseBody));
      } else {
        return Left(Failure(message: 'Failed to parse json response'));
      }
    } catch (e) {
      print('ERROR ==$e');
      return Left(Failure(message: 'Something went wrong'));
    }
  }
}
