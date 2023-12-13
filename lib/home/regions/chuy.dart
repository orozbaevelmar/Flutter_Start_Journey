import 'package:flutter/material.dart';

class Chuy extends StatelessWidget {
  var category = [
    'Hotel',
    'Sights',
    'Nature',
    'Snow Sport',
  ];
  var categoryColor = [
    Colors.amber.shade300,
    Colors.green.shade300,
    Colors.red.shade200,
    Colors.blue.shade300,
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (int i = 0; i < 4; i++)
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(3),
                      //padding: EdgeInsets.all(),
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(10),
                          //border: Border.all(color: Colors.black26),
                          ),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: categoryColor[i],
                              ),
                              child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'images/myIcons/icon$i.png',
                                ),
                              )),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              '${category[i]}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),

        /* child: Column(
          children: [
            Expanded(
              child: Container(
                height: 200,
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < 4; i++)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                            image: AssetImage(
                              'images/myIicons/icon1.png',
                            ),
                          ),
                        ),
                      ),
                    for (int i = 0; i < 4; i++)
                      Container(
                        color: Colors.green,
                        child: Text('Abcd',
                            style: TextStyle(
                              fontSize: 28,
                            )),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ), */
      ),
    );
  }
}
