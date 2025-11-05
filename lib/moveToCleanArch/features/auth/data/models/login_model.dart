import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String email;

  final String password;

  const LoginModel({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'password': password};
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  LoginModel copyWith({String? email, String? password}) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
