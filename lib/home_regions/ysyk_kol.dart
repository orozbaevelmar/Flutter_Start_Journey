import 'package:flutter/material.dart';

class Ysyk_Kol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /*  Container(
            height: 100.0,
            color: Colors.blue,
            child: Center(
              child: Text('Above ListView'),
            ),
          ), */

          Container(
            color: Colors.red,
            height: MediaQuery.of(context).padding.top,
          ),

          /* Container(
            height: 100.0,
            color: Colors.green,
            child: Center(
              child: Text('Below ListView'),
            ),
          ), */
        ],
      ),
    );
  }
}
