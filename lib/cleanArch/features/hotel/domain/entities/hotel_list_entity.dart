import 'package:start_journey/cleanArch/core/common/entity/places_entity.dart';

class HotelListEntity {
  int? count;
  String? next;
  String? previous;
  List<PlacesEntity>? results;
  HotelListEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
}
