import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/home/hotels/hotels_screen.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class PostScreen extends StatelessWidget {
  int whichHotel;
  PostScreen(this.whichHotel);

  var category = [
    'Wi-Fi',
    'Gym',
    'Parking',
    'Bar',
    'Air conditioning',
  ];

  Future<int> countFiles([
    String path = 'fds',
    //'${HotelsScreen.map.entries.elementAt(whichHotel).value.elementAt(2)}Door.jpg', //'assets/images/',
  ]) async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assetPaths = assetManifest
        .listAssets()
        .where((String key) => key.startsWith(path))
        .toList();

    debugPrint('Number of files in the $path folder: ${assetPaths.length}');
    return assetPaths.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(191, 191, 191, 1),
      body: _buildBody(context),
      bottomNavigationBar: _buildPriceAndBookingAtBottom(),
    );
  }

  // build body:----------------------------------------------------------------
  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          _buildAppBarWithBackgroundImage(context),
          _buildPostInformation(),
        ],
      ),
    );
  }

  // build app bar with bakground image:----------------------------------------
  Widget _buildAppBarWithBackgroundImage(context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            '${HotelsScreen.map.entries.elementAt(whichHotel).value.elementAt(2)}Door.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    //alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 25,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    //alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      HotelsScreen.map.entries
                              .elementAt(whichHotel)
                              .value
                              .elementAt(1)
                              .startsWith('u')
                          ? Icons.favorite_outline_outlined
                          : Icons.favorite,
                      size: 25,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  // build post information:----------------------------------------------------
  Widget _buildPostInformation() {
    return Container(
      margin: EdgeInsets.only(top: 380),
      decoration: BoxDecoration(
        color: Colors.white,
        //color: Color.fromRGBO(191, 191, 191, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildPostRoomImages(),
          _buildHotelsName(),
          _buildAmenities(),
          _buildDescription(),
        ],
      ),
    );
  }

  Widget _buildPostRoomImages() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(20),
          child: Text(
            'See All Room',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 2),
          height: 100,
          child: ListView.builder(
            itemCount: 6,
            /* HotelsScreen.map.entries
                              .elementAt(whichHotel)
                              .value
                              .length, //rewrote */
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 100,
                margin: EdgeInsets.only(right: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      '${HotelsScreen.map.entries.elementAt(whichHotel).value.elementAt(2)}$index.jpg', //rewrote
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHotelsName() {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Text(
        HotelsScreen.map.entries.elementAt(whichHotel).key, // rewrote
        style: GoogleFonts.frankRuhlLibre(
          fontSize: 43,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildAmenities() {
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

  Widget _buildDescription() {
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
            HotelsScreen.map.entries
                .elementAt(whichHotel)
                .value
                .elementAt(5), //rewrote
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w300,
              fontSize: 20,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }

  // build bottom navigation bar:-----------------------------------------------
  Widget _buildPriceAndBookingAtBottom() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
      padding: EdgeInsets.all(5),
      height: 90,
      child: Row(
        children: [
          Container(
            width: 130,
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              HotelsScreen.map.entries.elementAt(whichHotel).value.elementAt(4),
              style: GoogleFonts.lobster(
                  fontSize: 25, fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                    )
                  ]),
              child: Text(
                'Book Now',
                style: GoogleFonts.libreBaskerville(
                  fontSize: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
