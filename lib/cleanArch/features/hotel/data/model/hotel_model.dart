import 'package:start_journey/cleanArch/core/common/entity/places_entity.dart';
import 'package:start_journey/cleanArch/core/common/model/photo_model.dart';

class HotelModel extends PlacesEntity {
  HotelModel({
    super.id,
    super.name,
    super.location,
    super.isFavorite,
    super.rating,
    super.price,
    super.description,
    List<PhotoModel>? photos,
  }) : super(photos: photos);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['location'] = location;
    map['is_favorite'] = isFavorite;

    map['rating'] = rating;
    map['price'] = price;
    map['description'] = description;
    if (photos != null) {
      map['photos'] = photos!.map((e) => (e as PhotoModel).toMap()).toList();
    }
    return map;
  }

  factory HotelModel.fromJson(Map<String, dynamic> map) {
    return HotelModel(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      isFavorite: map['is_favorite'],
      rating: map['rating'],
      price: map['price'],
      description: map['description'],
      photos: map['photos'] != null
          ? List<PhotoModel>.from(
              (map['photos'] as List<dynamic>).map<PhotoModel?>(
                (x) => PhotoModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }
}
