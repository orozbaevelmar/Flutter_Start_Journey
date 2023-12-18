import 'package:flutter/material.dart';
import 'package:start_journey/home/hotels/hotels_screen.dart';
import 'package:start_journey/home/regions/batken.dart';
import 'package:start_journey/home/regions/chuy.dart';
import 'package:start_journey/home/regions/jalal_abad.dart';
import 'package:start_journey/home/regions/naryn.dart';
import 'package:start_journey/home/regions/osh.dart';
import 'package:start_journey/home/regions/talas.dart';
import 'package:start_journey/home/regions/ysyk_kol.dart';

class HomeScreen extends StatelessWidget {
  // hotel, snow sports, nature, sights,
  // nature --> waterfall, river, camping, mountain, lake,
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

  var nameOfRegions = [
    'Ysyk - Kol',
    'Chuy',
    'Batken',
    'Jalal-Abad',
    'Osh',
    'Naryn',
    'Talas'
  ];

  List<Widget> regionWidget = [
    Ysyk_Kol(),
    Chuy(),
    Batken(),
    Jalal_Abad(),
    Osh(),
    Naryn(),
    Talas(),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          //physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              //
              _homeAppBar(),
              _regionsTopLocatedOfScreen(),
              _homeCategories(context),
              _verticalScrollRegions(),
              //
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeAppBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.sort_rounded,
                size: 28,
              ),
            ),
          ),
          Text(
            "KYRGYZSTAN",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          Icon(
            Icons.search,
            size: 28,
          )
        ],
      ),
    );
  }

  Widget _regionsTopLocatedOfScreen() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 200, //200
            child: ListView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => regionWidget[index - 1],
                      ),
                    );
                  },
                  child: Container(
                    width: 160, //160
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        //city1.jpg
                        image:
                            AssetImage('images/regions/region${index + 1}.jpg'),
                        fit: BoxFit.cover,
                        opacity: 0.8,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.bookmark_border_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "${nameOfRegions[index++]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _homeCategories(context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (int i = 0; i < 4; i++)
            Expanded(
              child: Container(
                margin: EdgeInsets.all(3),
                //padding: EdgeInsets.all(),
                /* decoration: BoxDecoration(
                              //borderRadius: BorderRadius.circular(10),
                              //border: Border.all(color: Colors.black26),
                              ), */
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HotelsScreen(),
                          ),
                        );
                      },
                      child: Container(
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
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '${category[i]}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _verticalScrollRegions() {
    return ListView.builder(
      itemCount: 7,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      //opacity: 0.9,
                      image: AssetImage(
                        'images/regions/region${index + 1}.jpg',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'City Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
