import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/presentation/screen/favourite/store/favourite_store.dart';
import 'package:start_journey/presentation/screen/home/home_categories/hotel/hotel_post_screen.dart';
import 'package:start_journey/presentation/screen/home/home_categories/hotel/store/hotel_store.dart';
import 'package:start_journey/presentation/widget/app_bar.dart';
import 'package:start_journey/presentation/widget/search_text_field.dart';
import 'package:start_journey/presentation/widget/tag_line.dart';
import 'package:start_journey/utils/store_abstract_class/attraction.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  FavouriteStore _favouriteStore = FavouriteStore();
  HotelStore _hotelStore = HotelStore();

  void _searchResult(String newQuery) {
    setState(() {
      _hotelStore.searchResultHotel(newQuery);
    });
  }

  List<String> yourWishes = [
    'Near You',
    'Popular',
    'Luxury',
  ];

  TextEditingController _searchController = TextEditingController();

  double fontSizeBig = 35;
  double fontSizeMedium = 25;
  double fontSizeSmall = 15;

  @override
  Widget build(BuildContext context) {
    fontSizeBig = MediaQuery.of(context).size.width * 0.07;
    fontSizeMedium = MediaQuery.of(context).size.width * 0.055;
    fontSizeSmall = MediaQuery.of(context).size.width * 0.035;
    return PopScope(
      onPopInvoked: (bool didPop) {
        _hotelStore.onQueryChangedHotel('');
      },
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomAppBar(
              backButtonPressed: () {
                _hotelStore.onQueryChangedHotel('');
                Navigator.pop(context);
              },
            ),
            CustomTagLine(
                fontSizeBig: fontSizeBig, hintText: 'Hotels for all Desires'),
            CustomSearchTextField(
              hintText: 'Search for Hotels',
              fontSize: fontSizeSmall,
              controller: _searchController,
              onTap: () {
                _searchController.clear();
                setState(() {
                  _hotelStore.onQueryChangedHotel('');
                });
              },
              onChanged: _searchResult,
            ),
            HotelStore.queryHotel.isEmpty
                ? Column(
                    children: [
                      _hotelsTopLocatedOfScreen(),
                      _hotelCategory(),
                      _hotelsBottomLocatedOfScreen(),
                    ],
                  )
                : _hotelSearchScreen(),
          ],
        ),
      ),
    );
  }

  Widget _hotelSearchScreen() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          60 -
          65 -
          87 -
          15, // the height of _hotelAppBar(),_hotelTagline(),_hotelSearch() and padding(15)
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: HotelStore.searchResultsList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HotelPostScreen(HotelStore.searchResultsList[index]),
                  ),
                ) /* .then((value) => setState(() {})) */;
                /* setState(() {
                  // I set this setState, because when I in
                  // hotel_post_screen click arrow_back -> Navigator.pop(),
                  // Icon in HotelScreen will be changed.
                }); */
              },
              child: Container(
                height: 250, //width: 250,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(
                      '${_hotelStore.getPictures(HotelStore.searchResultsList[index])}hotel0.jpg',
                      /* '${HotelStore.mapHotelInformation[HotelStore.searchResultsList[index]]?.elementAt(2)}hotel0.jpg', */
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.9,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _hotelStore.getRating(
                                  HotelStore.searchResultsList[index]),
                              /* HotelStore.mapHotelInformation[
                                          HotelStore.searchResultsList[index]]
                                      ?.elementAt(3) ??
                                  '5', */
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // Favourite Icon
                          InkWell(
                            onTap: () {
                              setState(() {
                                _favouriteStore.checkRedFavouriteIcon(
                                        HotelStore.searchResultsList[index])
                                    ? _favouriteStore
                                        .deleteFromFavouriteElement(
                                            HotelStore.searchResultsList[index])
                                    : _favouriteStore.addToFavouriteElement(
                                        HotelStore.searchResultsList[index],
                                        HotelStore());
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
                              child: _favouriteStore.checkRedFavouriteIcon(
                                      HotelStore.searchResultsList[index])
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_outline_outlined,
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.bottomLeft,
                        //color: Colors.black12.withOpacity(0.2),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                HotelStore.searchResultsList[index],
                                /* HotelStore.mapHotelInformation.entries
                                          .elementAt(index)
                                          .key, */
                                style: GoogleFonts.acme(
                                  // acme // yeonsung
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3),
                                    child: Icon(
                                      Icons.location_on,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    _hotelStore.getLocation(
                                        HotelStore.searchResultsList[index]),
                                    /* HotelStore.mapHotelInformation[HotelStore
                                            .searchResultsList[index]]?[0] ??
                                        'Error at Hotels Location', */
                                    /* HotelStore.mapHotelInformation.entries
                                              .elementAt(index)
                                              .value
                                              .elementAt(0), */
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

          /* Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            height: 200,
            color: Colors.amber,
            //child: Image(image: AssetImage('images/nature.jpg')));
          ); */
        },
      ),
    );
  }

  Widget _hotelsTopLocatedOfScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 285,
        padding: const EdgeInsets.only(
          left: 15,
          right: 2,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          //shrinkWrap: true,
          //itemCount: HotelStore.mapHotelInformation.length,
          children: [
            for (var mapKey in _hotelStore.getMapInformation.keys)
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelPostScreen(mapKey),
                      ),
                    ).then((value) => setState(() {
                          // I set this setState, because when I in
                          // hotel_post_screen click arrow_back -> Navigator.pop(),
                          // Icon in HotelScreen will be changed.
                        }));
                  },
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(
                          '${_hotelStore.getPictures(mapKey)}hotel0.jpg',
                          /* '${HotelStore.mapHotelInformation[mapKey]?.elementAt(2)}hotel0.jpg' */
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.9,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  _hotelStore.getRating(mapKey),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              // Favourite Icon
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _favouriteStore
                                            .checkRedFavouriteIcon(mapKey)
                                        ? _favouriteStore
                                            .deleteFromFavouriteElement(mapKey)
                                        : _favouriteStore.addToFavouriteElement(
                                            mapKey, HotelStore());
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
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
                                          .checkRedFavouriteIcon(mapKey)
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.favorite_outline_outlined,
                                          color: Colors.black,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.bottomLeft,
                            //color: Colors.black12.withOpacity(0.2),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    mapKey,
                                    style: GoogleFonts.acme(
                                      // acme // yeonsung
                                      fontSize: fontSizeMedium,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 3),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        _hotelStore.getLocation(mapKey),
                                        style: TextStyle(
                                          fontSize: fontSizeSmall,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String mapKey) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelPostScreen(mapKey),
            ),
          ).then((value) => setState(() {
                // I set this setState, because when I in
                // hotel_post_screen click arrow_back -> Navigator.pop(),
                // Icon in HotelScreen will be changed.
              }));
        },
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(
                '${_hotelStore.getPictures(mapKey)}hotel0.jpg',
                /* '${HotelStore.mapHotelInformation[mapKey]?.elementAt(2)}hotel0.jpg' */
              ),
              fit: BoxFit.cover,
              opacity: 0.9,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _hotelStore.getRating(mapKey),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Favourite Icon
                    InkWell(
                      onTap: () {
                        setState(() {
                          _favouriteStore.checkRedFavouriteIcon(mapKey)
                              ? _favouriteStore
                                  .deleteFromFavouriteElement(mapKey)
                              : _favouriteStore.addToFavouriteElement(
                                  mapKey, HotelStore());
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
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
                        child: _favouriteStore.checkRedFavouriteIcon(mapKey)
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_outline_outlined,
                                color: Colors.black,
                              ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.bottomLeft,
                  //color: Colors.black12.withOpacity(0.2),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          mapKey,
                          style: GoogleFonts.acme(
                            // acme // yeonsung
                            fontSize: fontSizeMedium,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 3),
                              child: Icon(
                                Icons.location_on,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _hotelStore.getLocation(mapKey),
                              style: TextStyle(
                                fontSize: fontSizeSmall,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _hotelCategory() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            //
            // Will be deleted in the future
            // StatefulWidget

            Container(
              margin: EdgeInsets.only(
                right: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.green, // reWrote
                border: Border.all(
                  color: Colors.green, // reWrote
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Near You",
                  style: TextStyle(
                    fontSize: fontSizeSmall,
                    color: Colors.white, // rewrote
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Until here(_DELETE_)

            for (int i = 0; i < yourWishes.length; i++)
              Container(
                margin: EdgeInsets.only(
                  right: 20,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    yourWishes[i],
                    style: TextStyle(
                        fontSize: fontSizeSmall,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _hotelsBottomLocatedOfScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 220,
        padding: EdgeInsets.only(
          left: 15,
          right: 2,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 170,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(
                        'images/hotels/sheraton_bishkek/hotel0.jpg',
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.9,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '4.3*',
                                style: TextStyle(
                                  color: Colors.white,
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
                                  Icons.favorite_outline_outlined,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Blue Jazz',
                            style: GoogleFonts.acme(
                              // acme // yeonsung
                              fontSize: fontSizeMedium,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
