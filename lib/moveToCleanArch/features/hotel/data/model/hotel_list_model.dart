import 'package:start_journey/moveToCleanArch/features/hotel/data/model/hotel_model.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/domain/entities/hotel_list_entity.dart';

class HotelListModel extends HotelListEntity {
  HotelListModel({
    super.count,
    super.next,
    super.previous,
    List<HotelModel>? results,
  }) : super(results: results);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'count': count,
      'next': next,
      'previous': previous,
      'results': results != null
          ? results!.map((e) => (e as HotelModel).toJson()).toList()
          : []
    };
  }

  factory HotelListModel.fromJson(Map<String, dynamic> map) {
    return HotelListModel(
      count: map['count'],
      next: map['next'],
      previous: map['previous'],
      results: map['results'] != null
          ? List<HotelModel>.from(
              map['results'].map(
                (x) => HotelModel.fromJson(x),
              ),
            )
          : [],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory HotelListModel.fromJson(String response) {
  //   return HotelListModel.fromMap(
  //       json.decode(response) as Map<String, dynamic>);
  // }
}
