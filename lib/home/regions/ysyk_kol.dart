import 'package:flutter/material.dart';

class Ysyk_Kol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.topLeft,
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
              ],
            ),
          ),
        ),
        //),
      ),
    );
  }
}
