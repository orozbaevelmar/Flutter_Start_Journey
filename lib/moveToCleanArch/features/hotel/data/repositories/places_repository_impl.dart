// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:start_journey/moveToCleanArch/core/error/failures.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/data/datasources/hotel_remote_data_source.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/domain/entities/hotel_list_entity.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/domain/repositories/places_repository.dart';

class HotelRepositoryImpl implements PlacesRepository {
  final HotelRemoteDataSource remoteDataSource;
  HotelRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, HotelListEntity>> getAllHotels(
      {required String paginationUrl}) async {
    try {
      final hotels =
          await remoteDataSource.getAllHotels(paginationUrl: paginationUrl);

      return right(hotels);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
