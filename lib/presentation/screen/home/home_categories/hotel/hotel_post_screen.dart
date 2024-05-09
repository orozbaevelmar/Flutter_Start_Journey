import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/utils/constants/text_style_const.dart';
import 'package:start_journey/presentation/screen/favourite/store/favourite_store.dart';
import 'package:start_journey/presentation/screen/home/home_categories/hotel/store/hotel_store.dart';
import 'package:start_journey/presentation/widget/show_image_on_tap.dart';
import 'package:start_journey/utils/store_abstract_class/attraction.dart';

class HotelPostScreen extends StatefulWidget {
  final String attractionsName;

  HotelPostScreen(this.attractionsName);

  @override
  State<HotelPostScreen> createState() => _HotelPostScreenState();
}

class _HotelPostScreenState extends State<HotelPostScreen> {
  /* var _category = [
    'Wi-Fi',
    'Gym',
    'Parking',
    'Bar',
    'Air conditioning',
  ]; */

  HotelStore _hotelStore = HotelStore();
  FavouriteStore _favouriteStore = FavouriteStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(191, 191, 191, 1),
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
            _hotelStore.getPictureOfFacade(widget.attractionsName),
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
                  onTap: () {
                    setState(() {
                      _favouriteStore
                              .checkRedFavouriteIcon(widget.attractionsName)
                          ? _favouriteStore.deleteFromFavouriteElement(
                              widget.attractionsName)
                          : _favouriteStore.addToFavouriteElement(
                              widget.attractionsName, HotelStore());
                    });
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
                    child: _favouriteStore
                            .checkRedFavouriteIcon(widget.attractionsName)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 25,
                          )
                        : Icon(
                            Icons.favorite_outline_outlined,
                            color: Colors.black,
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
          child: FutureBuilder(
              future: _hotelStore.countFilesInFolder(
                _hotelStore.getMapInformation[widget.attractionsName]![2],
              ),
              /* HotelStore
                  .mapHotelInformation.entries
                  .elementAt(widget.whichHotel)
                  .value
                  .elementAt(2)), */
              initialData: 0,
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data,
                  /* HotelsScreen.map.entries
                                .elementAt(whichHotel)
                                .value
                                .length, //rewrote */
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowImageOnTap(HotelStore(),
                                widget.attractionsName, index, snapshot.data),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              '${_hotelStore.getPictures(widget.attractionsName)}hotel$index.jpg',
                              /* {HotelStore.mapHotelInformation[widget.whichHotel]?[2]} */
                              /* '${HotelStore.mapHotelInformation.entries.elementAt(widget.whichHotel).value.elementAt(2)}hotel$index.jpg', */ //rewrote
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

  Widget _buildHotelsName() {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Text(
        widget.attractionsName,
        /* HotelStore.mapHotelInformation.entries
            .elementAt(widget.whichHotel)
            .key, */ // rewrote
        style: GoogleFonts.frankRuhlLibre(
            textStyle: Theme.of(context).textTheme.headlineLarge

            /* const TextStyle(
            fontSize: 43,
            fontWeight: FontWeight.w400,
          ), */
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
            _hotelStore.getDescription(widget.attractionsName),
            /* HotelStore.mapHotelInformation[widget.whichHotel]![5], */
            /* HotelStore.mapHotelInformation.entries
                .elementAt(widget.whichHotel)
                .value
                .elementAt(5), */ //rewrote
            style: MTextStyle.description(Colors.black),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }

  // build bottom navigation bar:-----------------------------------------------
  Widget _buildPriceAndBookingAtBottom() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        left: 10,
        right: 10,
      ),
      padding: EdgeInsets.all(5),
      height: 90,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(
              _hotelStore.getPrice(widget.attractionsName),
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
