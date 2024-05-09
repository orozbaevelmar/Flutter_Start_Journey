import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class HotelsModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;
  HotelsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'next': next,
      'previous': previous,
      'results': results != null ? results!.map((e) => e.toJson()).toList() : []
    };
  }

  factory HotelsModel.fromMap(Map<String, dynamic> map) {
    return HotelsModel(
      count: map['count'],
      next: map['next'],
      previous: map['previous'],
      results: map['results'] != null
          ? List<Results>.from(
              (map['results'] as List<int>).map<Results?>(
                (x) => Results.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelsModel.fromJson(String response) =>
      HotelsModel.fromMap(json.decode(response) as Map<String, dynamic>);
}

class Results {
  String? hotelsName;
  String? location;
  bool? favorite;
  List<Photos>? photos;
  String? rating;
  String? price;
  String? description;
  Results({
    this.hotelsName,
    this.location,
    this.favorite,
    this.photos,
    this.rating,
    this.price,
    this.description,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};

    map['hotelsName'] = hotelsName;
    map['location'] = location;
    map['favorite'] = favorite;

    map['rating'] = rating;
    map['price'] = price;
    map['description'] = description;
    if (photos != null) {
      map['photos'] = photos!.map((e) => e.toMap()).toList();
    }
    return map;
  }

  factory Results.fromMap(Map<String, dynamic> map) {
    return Results(
      hotelsName: map['hotelsName'],
      location: map['location'],
      favorite: map['favorite'],
      photos: map['photos'] != null
          ? List<Photos>.from(
              (map['photos'] as List<int>).map<Photos?>(
                (x) => Photos.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      rating: map['rating'],
      price: map['price'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Results.fromJson(String response) =>
      Results.fromMap(json.decode(response) as Map<String, dynamic>);
}

class Photos {
  int? id;
  String? photo;
  Photos({
    this.id,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'photo': photo,
    };
  }

  factory Photos.fromMap(Map<String, dynamic> map) {
    return Photos(
      id: map['id'],
      photo: map['photo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Photos.fromJson(String response) =>
      Photos.fromMap(json.decode(response) as Map<String, dynamic>);
}
