import 'dart:convert';

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
              map['results'].map(
                (x) => Results.fromMap(x),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelsModel.fromJson(String response) {
    return HotelsModel.fromMap(json.decode(response) as Map<String, dynamic>);
  }
}

class Results {
  int? id;
  String? name;
  String? location;
  bool? isFavorite;
  double? rating;
  String? price;
  String? description;
  List<Photos>? photos;
  Results({
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

  factory Results.fromMap(Map<String, dynamic> map) {
    return Results(
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
