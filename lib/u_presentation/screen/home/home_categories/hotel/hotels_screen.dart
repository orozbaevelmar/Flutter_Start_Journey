import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/bloc/hotel/bloc.dart';
import 'package:start_journey/model/hotel.dart';
import 'package:start_journey/repository/favorites.dart';
import 'package:start_journey/u_presentation/screen/home/home_categories/hotel/hotel_post_screen.dart';
import 'package:start_journey/u_presentation/widget/app_bar.dart';
import 'package:start_journey/u_presentation/widget/components_attraction_screen/categories.dart';
import 'package:start_journey/u_presentation/widget/components_attraction_screen/name_and_location.dart';
import 'package:start_journey/u_presentation/widget/components_attraction_screen/rating_and_fav_icon.dart';
import 'package:start_journey/u_presentation/widget/empty_list.dart';
import 'package:start_journey/u_presentation/widget/search_text_field.dart';
import 'package:start_journey/u_presentation/widget/tag_line.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  @override
  void initState() {
    context.read<HotelBloc>().add(HotelLoadEvent());
    super.initState();
  }

  void _searchResult(String newQuery) {
    setState(() {
      _searchController;
    });
    context
        .read<HotelBloc>()
        .add(HotelSearchEvent(hotelsNameContains: newQuery, isInitial: true));
  }

  List<String> yourWishes = [
    'Near You',
    'Popular',
    'Luxury',
  ];

  final TextEditingController _searchController = TextEditingController();

  double fontSizeBig = 35;
  double fontSizeMedium = 25;
  double fontSizeSmall = 15;

  @override
  Widget build(BuildContext context) {
    fontSizeBig = MediaQuery.of(context).size.width * 0.07;
    fontSizeMedium = MediaQuery.of(context).size.width * 0.055;
    fontSizeSmall = MediaQuery.of(context).size.width * 0.035;
    return Scaffold(
      body: _buildBody(),
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
                setState(() {
                  _searchController.clear();
                });
              },
              onChanged: _searchResult,
            ),
            _searchController.text.isEmpty
                ? Column(
                    children: [
                      _hotelsTopLocatedOfScreen1(),
                      CustomCategories(
                          fontSizeSmall: fontSizeSmall, yourWishes: yourWishes),
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
    print("ABCDIFG");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          60 -
          65 -
          87 -
          15, // the height of _hotelAppBar(),_hotelTagline(),_hotelSearch() and padding(15)
      child: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          return switch (state) {
            HotelLoaded() => _buildSearcListView(state),
            HotelInitialLoading() ||
            HotelInitial() =>
              const Center(child: CircularProgressIndicator()),
            HotelEmpty() => EmptyListy(text: 'Not found Hotel with this name'),
            HotelInitialError() => Center(child: Text(state.message)),
          };
        },
      ),
    );
  }

  Widget _buildSearcListView(HotelLoaded state) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: state.hotelsModel.results?.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        Results result = state.hotelsModel.results![index];
        return _buildCard(
          state,
          index,
          250,
          double.infinity,
          EdgeInsets.symmetric(vertical: 10),
        ); //_buildSearchCard(result, state, index);
      },
    );
  }

  Widget _hotelsTopLocatedOfScreen1() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 285,
        padding: const EdgeInsets.only(
          left: 15,
          right: 2,
        ),
        child: BlocBuilder<HotelBloc, HotelState>(
          builder: (context, state) {
            return switch (state) {
              HotelLoaded() => _buildListView(state),
              HotelInitialLoading() ||
              HotelInitial() =>
                const Center(child: CircularProgressIndicator()),
              HotelEmpty() => const Center(child: Text('Empty Widget2')),
              HotelInitialError() => Center(child: Text(state.message)),
            };
          },
        ),
      ),
    );
  }

  Widget _buildListView(HotelLoaded state) {
    final hotelModel = state.hotelsModel;

    bool isNotLastPage = state.hotelsModel.next != null;

    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollInfo) {
        scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
                isNotLastPage
            ? context.read<HotelBloc>().add(HotelLoadEvent())
            : null;
        return true;
      },
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.hotelsModel.results?.length,
              itemBuilder: (context, index) {
                return _buildCard(
                  state,
                  index,
                  double.infinity,
                  250,
                  const EdgeInsets.only(right: 20),
                );
              },
            ),
          ),
          if (state.error != null)
            const Center(
              child: Text('On load more error'),
            ),
          if (state.loading != null) const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildCard(
    HotelLoaded state, //
    int index, //top:   search
    double height, // top :  search:250
    double width, // top :250  search:
    final EdgeInsetsGeometry padding,
  ) {
    Results result = state.hotelsModel.results![index];
    return Padding(
      padding: padding,
      //padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HotelPostScreen(results: result)),
          ).then((value) => setState(() {
                // I set this setState, because when I in
                // hotel_post_screen click arrow_back -> Navigator.pop(),
                // Icon in HotelScreen will be changed.
              }));
        },
        child: Container(
          width: width,
          height: height,
          //width: 250,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(
                result.photos?[0].photo ?? '',
              ),
              fit: BoxFit.cover,
              opacity: 0.9,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RatingAndFavoriteIcon(
                  rating: result.rating.toString(),
                  isFavorite: result.isFavorite ?? false,
                  onTapChangeFavoriteIcon: () async {
                    if (result.isFavorite ?? false) {
                      bool isDeleted = await FavoritesRepository
                          .deleteFavoritesVisualisation(result.id ?? -1);

                      if (isDeleted) {
                        setState(() {
                          state.hotelsModel.results![index].isFavorite = false;
                        });
                      }
                      return;
                    } else {
                      bool isPosted =
                          await FavoritesRepository.postFavoritesVisualisation(
                              result.id ?? -1);

                      if (isPosted) {
                        setState(() {
                          state.hotelsModel.results![index].isFavorite = true;
                        });
                      }
                    }
                  },
                ),
                AttractionNameAndLocation(
                  fontSizeMedium: fontSizeMedium,
                  fontSizeSmall: fontSizeSmall,
                  location: result.location ?? '',
                  name: result.name ?? '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* Widget _hotelsTopLocatedOfScreen() {
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
  } */

  /* Widget _buildCard(String mapKey) {
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
  } */

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RatingAndFavoriteIcon(
                            rating: '4.3*',
                            isFavorite: false,
                            onTapChangeFavoriteIcon: () {}),
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
