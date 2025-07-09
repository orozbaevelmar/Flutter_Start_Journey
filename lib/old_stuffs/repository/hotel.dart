// import 'package:dartz/dartz.dart';
// import 'package:start_journey/moveToCleanArch/core/error/failures.dart';
// import 'package:start_journey/moveToCleanArch/features/hotel/data/model/hotel_list_model.dart';

// class HotelRepository {
//   static Future<Either<Failure, HotelListModel>> getHotelsVisualisation(
//       {required String url}) async {
//     try {
//       final String responseBody = url;

//       if (4 > 3 /* response.statusCode == 200 */) {
//         return Right(HotelListModel.fromJson(responseBody));
//       } else {
//         return Left(Failure(message: 'Failed to parse json response'));
//       }
//     } catch (e) {
//       return Left(Failure(message: 'Something went wrong'));
//     }
//   }
// }
