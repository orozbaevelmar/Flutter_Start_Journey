// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:start_journey/model/extra/results.dart';

class HotelsModel {
  int? count;
  String? next;
  String? previous;
  List<Result>? results;
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
          ? List<Result>.from(
              map['results'].map(
                (x) => Result.fromMap(x),
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
