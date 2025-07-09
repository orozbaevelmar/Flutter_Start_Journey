import 'package:start_journey/moveToCleanArch/core/common/model/photo_model.dart';
import 'package:start_journey/moveToCleanArch/core/common/entity/photo_entity.dart';

class PlacesEntity {
  int? id;
  String? name;
  String? location;
  bool? isFavorite;
  double? rating;
  String? price;
  String? description;
  List<PhotosEntity>? photos;
  PlacesEntity({
    this.id,
    this.name,
    this.location,
    this.isFavorite,
    this.rating,
    this.price,
    this.description,
    this.photos,
  });
}
