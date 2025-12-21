import 'package:dartz/dartz.dart';
import 'package:start_journey/cleanArch/core/error/failures.dart';
import 'package:start_journey/cleanArch/features/hotel/domain/entities/hotel_list_entity.dart';

abstract interface class PlacesRepository {
  Future<Either<Failure, HotelListEntity>> getAllHotels(
      {required String paginationUrl});
}
