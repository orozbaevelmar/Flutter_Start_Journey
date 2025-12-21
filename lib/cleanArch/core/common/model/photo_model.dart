import 'dart:convert';

import 'package:start_journey/cleanArch/core/common/entity/photo_entity.dart';

class PhotoModel extends PhotosEntity {
  PhotoModel({
    super.id,
    super.photo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'photo': photo,
    };
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      id: map['id'],
      photo: map['photo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoModel.fromJson(String response) =>
      PhotoModel.fromMap(json.decode(response) as Map<String, dynamic>);
}
