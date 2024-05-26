import 'dart:convert';

import 'package:start_journey/model/extra/results.dart';

class SightsModel {
  int? count;
  String? next;
  String? previous;
  List<Result>? results;
  SightsModel({
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

  factory SightsModel.fromMap(Map<String, dynamic> map) {
    return SightsModel(
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

  factory SightsModel.fromJson(String response) {
    return SightsModel.fromMap(json.decode(response) as Map<String, dynamic>);
  }
}
