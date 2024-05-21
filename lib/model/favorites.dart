import 'dart:convert';

class FavoritesModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  FavoritesModel({this.count, this.next, this.previous, this.results});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'next': next,
      'previous': previous,
      'results': results != null ? results!.map((e) => e.toJson()).toList() : []
    };
  }

  factory FavoritesModel.fromMap(Map<String, dynamic> map) {
    return FavoritesModel(
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

  factory FavoritesModel.fromJson(String response) {
    return FavoritesModel.fromMap(
        json.decode(response) as Map<String, dynamic>);
  }
}

class Results {
  int? id;
  FavoriteId? drugId;
  Results({
    this.id,
    this.drugId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'drug_id': drugId,
    };
  }

  factory Results.fromMap(Map<String, dynamic> map) {
    return Results(
      id: map['id'],
      drugId: map['drug_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Results.fromJson(String response) {
    return Results.fromMap(json.decode(response) as Map<String, dynamic>);
  }
}

class FavoriteId {
  int? id;
  String? name;
  String? location;
  bool? isFavorite;
  double? rating;
  String? price;
  String? description;
  List<Photos>? photos;
  FavoriteId({
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

  factory FavoriteId.fromMap(Map<String, dynamic> map) {
    return FavoriteId(
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

  factory FavoriteId.fromJson(String response) =>
      FavoriteId.fromMap(json.decode(response) as Map<String, dynamic>);
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
