import 'package:flutter/material.dart';

class Amenities extends StatelessWidget {
  const Amenities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 20,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            'Amenities',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 85, //80
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              for (int i = 0; i < 5; i++)
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white60,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/amenitiesIcon/amenities$i.png',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
