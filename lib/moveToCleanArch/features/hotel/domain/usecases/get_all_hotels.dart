import 'package:dartz/dartz.dart';
import 'package:start_journey/moveToCleanArch/core/error/failures.dart';
import 'package:start_journey/moveToCleanArch/core/usecases/usecase.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/domain/entities/hotel_list_entity.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/domain/repositories/places_repository.dart';

class GetHotelsUseCase implements UseCase<HotelListEntity, String> {
  final PlacesRepository hotelRepository;

  GetHotelsUseCase(this.hotelRepository);
  @override
  Future<Either<Failure, HotelListEntity>> call(String paginationUrl) {
    final res = hotelRepository.getAllHotels(paginationUrl: paginationUrl);

    return res;
  }
}
