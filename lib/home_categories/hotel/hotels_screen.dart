import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/favourite/store/favourite_store.dart';
import 'package:start_journey/home_categories/hotel/hotel_post_screen.dart';
import 'package:start_journey/home_categories/hotel/store/hotel_store.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  FavouriteStore _favouriteStore = FavouriteStore();

  List<String> yourWishes = [
    'Near You',
    'Popular',
    'Luxury',
  ];

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _hotelAppBar(),
            _hotelTagline(),
            _hotelSearch(),
            _hotelsTopLocatedOfScreen(),
            _hotelCategory(),
            _hotelsBottomLocatedOfScreen(),
          ],
        ),
      ),
    );
  }

  Widget _hotelAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            iconSize: 35,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 35,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'images/nature.jpg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hotelTagline() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        'Hotels for all Desires', //'Best Hotels is here',// hospitable hotels are waiting for you //hotels for all desires
        style: GoogleFonts.frankRuhlLibre(
          fontSize: 35,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _hotelSearch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      child: TextField(
        style: const TextStyle(
          fontSize: 18,
        ),
        controller: _searchController,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: const Icon(Icons.search_outlined),
          hintText: 'Search for Hotels',
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
            },
          ),
        ),
        onTapOutside: (event) {
          //FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTap: () {},
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
            shrinkWrap: true,
            //itemCount: HotelStore.mapHotelInformation.length,
            children: [
              for (var mapKey in HotelStore.mapHotelInformation.keys)
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostScreen(mapKey),
                        ),
                      );
                    },
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                              '${HotelStore.mapHotelInformation[mapKey]?.elementAt(2)}hotel0.jpg'),
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
                                    HotelStore.mapHotelInformation[mapKey]
                                            ?.elementAt(3) ??
                                        '5',
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
                                              .deleteFromFavouriteElement(
                                                  mapKey)
                                          : _favouriteStore
                                              .addToFavouriteElement(mapKey);
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
                            Spacer(),
                            Container(
                              alignment: Alignment.bottomLeft,
                              //color: Colors.black12.withOpacity(0.2),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      mapKey,
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
                                          padding:
                                              const EdgeInsets.only(right: 3),
                                          child: Icon(
                                            Icons.location_on,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          HotelStore.mapHotelInformation[mapKey]
                                                  ?[0] ??
                                              'Error at Hotels Location',
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
                ),
            ],
          )),
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
                    fontSize: 16,
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
                        fontSize: 16,
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
                              fontSize: 25,
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
