import 'dart:convert';
import 'package:start_journey/z_stuffs/model/extra/photo.dart';

class Result {
  int? id;
  String? name;
  String? location;
  bool? isFavorite;
  double? rating;
  String? price;
  String? description;
  List<Photos>? photos;
  Result({
    this.id,
    this.name,
    this.location,
    this.isFavorite,
    this.rating,
    this.price,
    this.description,
    this.photos,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['location'] = location;
    map['is_favorite'] = isFavorite;

    map['rating'] = rating;
    map['price'] = price;
    map['description'] = description;
    if (photos != null) {
      map['photos'] = photos!.map((e) => e.toMap()).toList();
    }
    return map;
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      isFavorite: map['is_favorite'],
      rating: map['rating'],
      price: map['price'],
      description: map['description'],
      photos: map['photos'] != null
          ? List<Photos>.from(
              (map['photos'] as List<dynamic>).map<Photos?>(
                (x) => Photos.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String response) =>
      Result.fromMap(json.decode(response) as Map<String, dynamic>);
}
