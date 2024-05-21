import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/bloc/favorites/bloc.dart';
import 'package:start_journey/model/hotel.dart';
import 'package:start_journey/repository/favorites.dart';
import 'package:start_journey/u_presentation/screen/favourite/store/favourite_store.dart';
import 'package:start_journey/u_presentation/widget/components_attraction_screen/name_and_location.dart';
import 'package:start_journey/u_presentation/widget/components_attraction_screen/rating_and_fav_icon.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavouriteStore _favouriteStore = FavouriteStore();

  double fontSize = 18;
  @override
  void initState() {
    context.read<FavoritesBloc>().add(FavoritesLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fontSize = MediaQuery.of(context).size.width * 0.04;
    return _buildBody();
  }

  Widget _buildBody() {
    return _hasFavouriteElements1();
  }

  Widget _noFavouriteElement() {
    print("TRUE");
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
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
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  /* Widget _hasFavouriteElements() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              for (var mapKey
                  in FavouriteStore.favouriteElementsInLinkedHashMap.keys)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouriteStore
                            .favouriteElementsInLinkedHashMap[mapKey]!
                            .getPostScreen(mapKey ?? 'It may need fixes'),
                        /* FavouriteStore.favouriteElementsInLinkedHashMap[mapKey]?.elementAt(1)(mapkey) --> PostScreen */

                        /* HotelPostScreen(FavouriteStore
                              .favouriteElementsInLinkedHashMap.
                                .elementAt(index) ??
                            'Not Found in Favourite Screen PostScreen') */
                      ),
                    );
                  },
                  child: _favouriteElementBody(mapKey),
                ),
            ],
          ),
        ),
      ),
    );
  } */

  Widget _hasFavouriteElements1() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            return switch (state) {
              FavoritesLoaded() => state.favoritesModel.results!.isNotEmpty
                  ? _buildListView(state)
                  : _noFavouriteElement(),
              FavoritesInitialLoading() ||
              FavoritesInitial() =>
                const Center(child: CircularProgressIndicator()),
              FavoritesEmpty() => const Center(child: Text('Empty Widget2')),
              FavoritesInitialError() => Center(child: Text(state.message)),
            };
          },
        ),
      ),
    );
  }

  Widget _buildListView(FavoritesLoaded state) {
    final favoritesModel = state.favoritesModel;
    bool isNotLastPage = state.favoritesModel.next != null;
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollInfo) {
        scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
                isNotLastPage
            ? context.read<FavoritesBloc>().add(FavoritesLoadEvent())
            : null;
        return true;
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: favoritesModel.results?.length,
              itemBuilder: (context, index) {
                final model = favoritesModel.results![index];
                return InkWell(
                  onTap: () {
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouriteStore
                            .favouriteElementsInLinkedHashMap[mapKey]!
                            .getPostScreen(mapKey ?? 'It may need fixes'),
                        /* FavouriteStore.favouriteElementsInLinkedHashMap[mapKey]?.elementAt(1)(mapkey) --> PostScreen */
            
                        /* HotelPostScreen(FavouriteStore
                                          .favouriteElementsInLinkedHashMap.
                                            .elementAt(index) ??
                                        'Not Found in Favourite Screen PostScreen') */
                      ),
                    ); */
                  },
                  child: _favouriteElementBody(model, index),
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

  Widget _favouriteElementBody(Results result, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 300,
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
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RatingAndFavoriteIcon(
              rating: result.rating.toString(),
              isFavorite: result.isFavorite ?? false,
              onTapChangeFavoriteIcon: () async {
                if (result.isFavorite ?? false) {
                  bool isDeleted =
                      await FavoritesRepository.deleteFavoritesVisualisation(
                          result.id ?? -1);

                  if (isDeleted) {
                    setState(() {
                      result.isFavorite = false;
                    });
                  }
                } else if (result.isFavorite == false) {
                  bool isPosted =
                      await FavoritesRepository.postFavoritesVisualisation(
                          result.id ?? -1);

                  if (isPosted) {
                    setState(
                      () {
                        result.isFavorite = true;
                      },
                    );
                  }
                }
              },
            ),
            AttractionNameAndLocation(
              fontSizeMedium: 30, //fontSizeMedium,
              fontSizeSmall: 20, //fontSizeSmall,
              location: result.location ?? '',
              name: result.name ?? '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildElementsRating(mapKey) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        /* FavouriteStore.favouriteElementsInLinkedHashMap[mapKey]?.getPictureOfFacade(mapKey) ?? 'It may need fixes' */
        FavouriteStore.favouriteElementsInLinkedHashMap[mapKey]
                ?.getRating(mapKey) ??
            'It may need fixes',
        /* HotelStore.mapHotelInformation[FavouriteStore
                    .favouriteElementsInLinkedHashSet
                    .elementAt(index)]
                ?.elementAt(3) ??
            '5', */
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFavouriteIcon(mapKey) {
    return InkWell(
      onTap: () {
        setState(() {
          /* _favouriteStore.checkRedFavouriteIcon(mapKey)
              ? _favouriteStore
                  . */
          if (_favouriteStore.checkRedFavouriteIcon(mapKey))
            _favouriteStore
                .deleteFromFavouriteElement(mapKey ?? 'It may need fixes');
          /* : _favouriteStore.addToFavouriteElement(
                  mapKey,
                  FavouriteStore.favouriteElementsInLinkedHashMap[mapKey]
                          ?.elementAt(1)
                      /* FavouriteStore
                      .favouriteElementsInLinkedHashSet
                      .elementAt(index) */
                      ??
                      'It may need fixes'); */
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
    );
  }

  Widget _buildElementsName(mapKey) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        // it may need fixes
        mapKey ?? 'It may need fixes',
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

  Widget _buildElementsLocation(mapKey) {
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
            FavouriteStore.favouriteElementsInLinkedHashMap[mapKey]
                    ?.getLocation(mapKey)
                /* ?.elementAt(0)[mapKey][0] */
                /* HotelStore.mapHotelInformation[FavouriteStore
                    .favouriteElementsInLinkedHashSet
                    .elementAt(index)]?[0] */
                ??
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
