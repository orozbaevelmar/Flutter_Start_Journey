import 'package:flutter/material.dart';
import 'package:start_journey/old_stuffs/utils/constants/text_style_const.dart';

class PostDescription extends StatelessWidget {
  const PostDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            'Description',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            top: 10,
            right: 20,
          ),
          child: Text(
            description,
            style: MTextStyle.description(Colors.black),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
