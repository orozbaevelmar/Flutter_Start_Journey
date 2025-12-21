import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:start_journey/cleanArch/core/error/failures.dart';
import 'package:start_journey/cleanArch/core/use_cases/use_case.dart';
import 'package:start_journey/cleanArch/features/hotel/domain/entities/hotel_list_entity.dart';
import 'package:start_journey/cleanArch/features/hotel/domain/repositories/places_repository.dart';

@lazySingleton
class GetHotelsUseCase implements UseCase<HotelListEntity, String> {
  final PlacesRepository hotelRepository;

  GetHotelsUseCase(this.hotelRepository);
  @override
  Future<Either<Failure, HotelListEntity>> call(String paginationUrl) {
    final res = hotelRepository.getAllHotels(paginationUrl: paginationUrl);

    return res;
  }
}
