import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/bloc/favorites/bloc.dart';
import 'package:start_journey/model/extra/results.dart';
import 'package:start_journey/repository/favorites.dart';
import 'package:start_journey/u_presentation/screen/home/home_categories/attraction_post_screen.dart';
import 'package:start_journey/u_presentation/screen/home/home_categories/components_attraction_screen/name_and_location.dart';
import 'package:start_journey/u_presentation/screen/home/home_categories/components_attraction_screen/rating_and_fav_icon.dart';
import 'package:start_journey/u_presentation/widget/empty_list.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  //double fontSize = 18;
  @override
  void initState() {
    context.read<FavoritesBloc>().add(FavoritesLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //fontSize = MediaQuery.of(context).size.width * 0.04;
    return _buildBody();
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            return switch (state) {
              FavoritesLoaded() => (state.favoritesModel.results?.isNotEmpty ??
                      false)
                  ? _buildListView(state)
                  : EmptyListy(text: 'You don\'t have favorite elements yet.'),
              FavoritesInitialLoading() ||
              FavoritesInitial() =>
                const Center(child: CircularProgressIndicator()),
              FavoritesEmpty() => EmptyListy(
                  text: 'You don\'t have favorite elements yet.',
                ),
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
                return _buildCard(model, index);
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

  Widget _buildCard(Result result, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AttractionPostScreen(
              results: result,
            ),
          ),
        ).then((value) => setState(() {
              result.isFavorite;
            }));
      },
      child: Container(
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
                    bool isDeleted = await FavoritesRepository
                        .deleteFavoritesVisualisationHotel(result.id ?? -1);

                    if (isDeleted) {
                      setState(() {
                        result.isFavorite = false;
                      });
                      if (mounted) {
                        context
                            .read<FavoritesBloc>()
                            .add(FavoriteDrugRemoveEvent(result));
                      }
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
      ),
    );
  }
}
