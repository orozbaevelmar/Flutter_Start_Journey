// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HorizListView extends StatelessWidget {
  final String name;
  final String location;
  final String star;
  final String isFavorite;
  final String photo;
  final VoidCallback onTap;
  const HorizListView({
    Key? key,
    required this.name,
    required this.location,
    required this.star,
    required this.isFavorite,
    required this.photo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
