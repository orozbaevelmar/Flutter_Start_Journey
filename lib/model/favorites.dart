import 'dart:convert';

import 'package:start_journey/model/extra/results.dart';

class FavoritesModel {
  int? count;
  String? next;
  String? previous;
  List<Result>? results;

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
          ? List<Result>.from(
              map['results'].map(
                (x) => Result.fromMap(x),
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

class FavoriteId {
  int? id;
  Result? drugId;
  FavoriteId({
    this.id,
    this.drugId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'drug_id': drugId,
    };
  }

  factory FavoriteId.fromMap(Map<String, dynamic> map) {
    return FavoriteId(
      id: map['id'],
      drugId: map['drug_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteId.fromJson(String response) {
    return FavoriteId.fromMap(json.decode(response) as Map<String, dynamic>);
  }
}
