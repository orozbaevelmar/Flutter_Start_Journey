// import 'package:dartz/dartz.dart';
// import 'package:start_journey/moveToCleanArch/core/error/failures.dart';
// import 'package:start_journey/old_stuffs/model/sights.dart';
// import 'package:start_journey/old_stuffs/utils/failure.dart';

// class SightsRepository {
//   static Future<Either<Failure, SightsModel>> getSightsVisualisation(
//       {required String url}) async {
//     SightsModel.fromJson(url);
//     try {
//       final String responseBody = url;

//       if (4 > 3 /* response.statusCode == 200 */) {
//         return Right(SightsModel.fromJson(responseBody));
//       } else {
//         return Left(ServerFailure(message: 'Failed to parse json response'));
//       }
//     } catch (e) {
//       print('ERROR ==$e');
//       return Left(ServerFailure(message: 'Something went wrong'));
//     }
//   }
// }
