import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegionPostScreen extends StatelessWidget {
  final String photo;
  final String name;
  RegionPostScreen({
    super.key,
    required this.photo,
    required this.name,
  });

  final List<String> listPhoto = [
    'images/hotels/jannat_resort/hotel0.jpg',
    'images/hotels/jannat_resort/hotel3.jpg',
    'images/hotels/jannat_resort/hotelDoor.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _photoWithComments(context),
          ],
        ),
      ),
    );
  }

  int abc(int i) {
    print(i);
    return i;
  }

  Widget _photoWithComments(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 30,
        left: 30,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(photo),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Stack(
              children: [
                for (int i = listPhoto.length - 1; i >= 0; i--)
                  Container(
                    margin: EdgeInsets.only(left: i * 15),
                    height: 35,
                    width: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        listPhoto[abc(i)],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Antelope Canyon',
            // name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                '\$499',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Text(
                'per\nperson',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
