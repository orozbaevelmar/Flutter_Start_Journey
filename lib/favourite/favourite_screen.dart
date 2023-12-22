import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/favourite/store/favourite_store.dart';
import 'package:start_journey/home_categories/hotel/hotel_post_screen.dart';
import 'package:start_journey/home_categories/hotel/store/hotel_store.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavouriteStore _favouriteStore = FavouriteStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FavouriteStore.favouriteElementsInLinkedHashSet.isEmpty
        ? _noFavouriteElement()
        : _hasFavouriteElements();
  }

  Widget _noFavouriteElement() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'You don\'t have favorite elements yet.',
          style: GoogleFonts.frankRuhlLibre(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _hasFavouriteElements() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: FavouriteStore.favouriteElementsInLinkedHashSet.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScreen(FavouriteStore
                              .favouriteElementsInLinkedHashSet
                              .elementAt(index) ??
                          'Not Found in Favourite Screen PostScreen'),
                    ),
                  );
                },
                child: _favouriteElementBody(index),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _favouriteElementBody(index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(
            //HotelStore.mapHotelInformation[FavouriteStore
            // .favouriteElementsInLinkedHashSet
            //   .elementAt(index)]!
            //  .elementAt(3),

            //  '${HotelStore.mapHotelInformation.entries.elementAt(index).value.elementAt(2)}hotelDoor.jpg'
            '${HotelStore.mapHotelInformation[FavouriteStore.favouriteElementsInLinkedHashSet.elementAt(index)]?.elementAt(2)}hotelDoor.jpg',
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
                _buildElementsRating(index),
                _buildFavouriteIcon(index),
              ],
            ),
            Spacer(),
            Container(
              alignment: Alignment.bottomLeft,
              //color: Colors.black12.withOpacity(0.2),
              child: Column(
                children: [
                  _buildElementsName(index),
                  _buildElementsLocation(index),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildElementsRating(index) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        HotelStore.mapHotelInformation[FavouriteStore
                    .favouriteElementsInLinkedHashSet
                    .elementAt(index)]
                ?.elementAt(3) ??
            '5',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFavouriteIcon(index) {
    return InkWell(
      onTap: () {
        setState(() {
          _favouriteStore.checkRedFavouriteIcon(FavouriteStore
                      .favouriteElementsInLinkedHashSet
                      .elementAt(index) ??
                  'It may need fixes')
              ? _favouriteStore.deleteFromFavouriteElement(FavouriteStore
                      .favouriteElementsInLinkedHashSet
                      .elementAt(index) ??
                  'It may need fixes')
              : _favouriteStore.addToFavouriteElement(FavouriteStore
                      .favouriteElementsInLinkedHashSet
                      .elementAt(index) ??
                  'It may need fixes');
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
        // It may need fixes
        child: _favouriteStore.checkRedFavouriteIcon(FavouriteStore
                    .favouriteElementsInLinkedHashSet
                    .elementAt(index) ??
                'abc')
            ? Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : Icon(
                Icons.favorite_outline_outlined,
                color: Colors.black,
              ),
      ),
    );
  }

  Widget _buildElementsName(index) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        // it may need fixes
        FavouriteStore.favouriteElementsInLinkedHashSet.elementAt(index) ??
            'It may need fixes',
        /* HotelStore.mapHotelInformation.entries
            .elementAt(index)
            .key, //hotelsName[index], */
        style: GoogleFonts.acme(
          // acme // yeonsung
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildElementsLocation(index) {
    return Container(
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
            HotelStore.mapHotelInformation[FavouriteStore
                    .favouriteElementsInLinkedHashSet
                    .elementAt(index)]?[0] ??
                "It may need fixes",
            /* FavouriteStore.favouriteElementsInLinkedHashSet.elementAt(1) */
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
