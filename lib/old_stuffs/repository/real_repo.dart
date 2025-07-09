// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:start_journey/moveToCleanArch/core/error/failures.dart';
// import 'package:start_journey/moveToCleanArch/features/hotel/data/model/hotel_list_model.dart';
// import 'package:start_journey/old_stuffs/utils/dependency_injection.dart';
// import 'package:start_journey/old_stuffs/utils/locale_secure_storage.dart';
// import 'package:http/http.dart' as http;

// class HotelRepositoryInReality {
//   static Future<Either<Failure, HotelListModel>> getHotelsInReality(
//       {required String url}) async {
//     try {
//       var uri = Uri.parse(url);
//       var headers = {
//         'Authorithation':
//             'token ${getIt.get<LocaleSecureStorage>().getSecureToken()}'
//       };

//       final response = await http.get(uri, headers: headers);

//       if (response.statusCode == 200) {
//         String responseBody = utf8.decode(response.bodyBytes);
//         return Right(HotelListModel.fromJson(responseBody));
//       } else {
//         return Left(ServerFailure(message: 'Failed to parse json response'));
//       }
//     } catch (e) {
//       return Left(ServerFailure(message: 'Something went wrong'));
//     }
//   }
// }
