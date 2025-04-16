import 'package:flutter/material.dart';

class TripJournal extends StatelessWidget {
  TripJournal({super.key});

  final List<String> list = [
    'Journal Screen\n',
    'I can write here how man plans his journey.',
    'He can choose some places, which he wants to go.',
    'Our server will recommend, which place can he go first, second, third.',
    'With other words, he will build a route of places, with help of Latitude and Longtitude,'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              for (int i = 0; i < list.length; i++) Text(list[i]),
            ],
          ),
        ),
      ),
    );
  }
}
