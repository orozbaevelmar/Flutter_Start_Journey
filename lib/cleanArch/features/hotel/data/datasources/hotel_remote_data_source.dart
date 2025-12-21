import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:start_journey/cleanArch/core/error/exceptions.dart';
import 'package:start_journey/cleanArch/features/hotel/data/model/hotel_list_model.dart';
import 'package:start_journey/cleanArch/features/hotel/domain/entities/hotel_list_entity.dart';

abstract interface class HotelRemoteDataSource {
  Future<HotelListEntity> getAllHotels({required String paginationUrl});
}

@LazySingleton(as: HotelRemoteDataSource)
class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
  final Dio dio;

  HotelRemoteDataSourceImpl({required this.dio});

  @override
  Future<HotelListEntity> getAllHotels({required String paginationUrl}) async {
    /// Mock
    try {
      final String responseBody = paginationUrl;
      final map1 = json.decode(responseBody) as Map<String, dynamic>;

      if (4 > 3) {
        return HotelListModel.fromJson(map1);
      } else {
        throw ServerException('Something went wrong');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }

    ///
    /// Real API
    ///
    // try {
    //   final response = await dio.get(paginationUrl,
    //       options: Options(headers: {
    //         'Authorization':
    //             'token ${getIt<LocaleSecureStorage>().getSecureToken()}'
    //       }));

    //   if (response.statusCode == 200) {
    //     return HotelListModel.fromJson(response.data);
    //   } else {
    //     throw ServerException(message: 'Something went wrong');
    //   }
    // } on DioException catch (e) {
    //   throw ServerException(message: e.toString());
    // } catch (e) {
    //   throw ServerException(message: e.toString());
    // }
  }
}
