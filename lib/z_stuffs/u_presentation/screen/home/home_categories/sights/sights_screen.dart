import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/z_stuffs/bloc/sights/bloc.dart';
import 'package:start_journey/z_stuffs/model/extra/results.dart';
import 'package:start_journey/z_stuffs/repository/favorites.dart';
import 'package:start_journey/z_stuffs/u_presentation/screen/home/home_categories/post_screen/attraction_post_screen.dart';
import 'package:start_journey/z_stuffs/u_presentation/widget/app_bar.dart';
import 'package:start_journey/z_stuffs/u_presentation/screen/home/home_categories/components/categories.dart';
import 'package:start_journey/z_stuffs/u_presentation/screen/home/home_categories/components/mini_attraction.dart';
import 'package:start_journey/z_stuffs/u_presentation/screen/home/home_categories/components/name_and_location.dart';
import 'package:start_journey/z_stuffs/u_presentation/screen/home/home_categories/components/rating_and_fav_icon.dart';
import 'package:start_journey/z_stuffs/u_presentation/widget/empty_list.dart';
import 'package:start_journey/z_stuffs/u_presentation/widget/search_text_field.dart';
import 'package:start_journey/z_stuffs/u_presentation/widget/tag_line.dart';
import 'package:start_journey/z_stuffs/utils/constants/navigator_custom.dart';

class SightsScreen extends StatefulWidget {
  const SightsScreen({super.key});

  @override
  State<SightsScreen> createState() => _SightsScreenState();
}

class _SightsScreenState extends State<SightsScreen> {
  @override
  void initState() {
    context.read<SightsBloc>().add(SightsLoadEvent());
    super.initState();
  }

  void _searchResult(String newQuery) {
    setState(() {
      _searchController;
    });
    if (newQuery.isEmpty) {
      context.read<SightsBloc>().add(SightsLoadEvent());
      return;
    }
    context
        .read<SightsBloc>()
        .add(SightsSearchEvent(sightsNameContains: newQuery, isInitial: true));
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
              backButtonPressed: () => Go.back(context),
            ),
            CustomTagLine(
                fontSizeBig: fontSizeBig, hintText: 'Sights for all Desires'),
            CustomSearchTextField(
              hintText: 'Search for Sights',
              fontSize: fontSizeSmall,
              controller: _searchController,
              onTap: () {
                setState(() => _searchController.clear());
                context.read<SightsBloc>().add(SightsLoadEvent());
              },
              onChanged: _searchResult,
            ),
            _searchController.text.isEmpty
                ? Column(
                    children: [
                      _sightsTopLocatedOfScreen1(),
                      CustomFilterAttraction(
                          fontSizeSmall: fontSizeSmall, yourWishes: yourWishes),
                      MiniAttractionAtBottom(
                        fontSizeMedium: fontSizeMedium,
                        photo: 'images/sights/ruh_ordo/sights0.jpg',
                      )
                    ],
                  )
                : _sightsSearchScreen(),
          ],
        ),
      ),
    );
  }

  Widget _sightsSearchScreen() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          60 -
          65 -
          87 -
          15, // the height of _sightsAppBar(),_sightsTagline(),_sightsSearch() and padding(15)
      child: BlocBuilder<SightsBloc, SightsState>(
        builder: (context, state) {
          return switch (state) {
            SightsLoaded() => _buildSearcListView(state),
            SightsInitialLoading() ||
            SightsInitial() =>
              const Center(child: CircularProgressIndicator()),
            SightsEmpty() =>
              EmptyListy(text: 'Not found Sights with this name'),
            SightsInitialError() => Center(child: Text(state.message)),
          };
        },
      ),
    );
  }

  Widget _buildSearcListView(SightsLoaded state) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: state.sightsModel.results?.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return _buildCard(
          state,
          index,
          250,
          double.infinity,
          const EdgeInsets.symmetric(vertical: 10),
        ); //_buildSearchCard(result, state, index);
      },
    );
  }

  Widget _sightsTopLocatedOfScreen1() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 285,
        padding: const EdgeInsets.only(
          left: 15,
          right: 2,
        ),
        child: BlocBuilder<SightsBloc, SightsState>(
          builder: (context, state) {
            return switch (state) {
              SightsLoaded() => _buildListView(state),
              SightsInitialLoading() ||
              SightsInitial() =>
                const Center(child: CircularProgressIndicator()),
              SightsEmpty() => const Center(child: Text('Empty Widget2')),
              SightsInitialError() => Center(child: Text(state.message)),
            };
          },
        ),
      ),
    );
  }

  Widget _buildListView(SightsLoaded state) {
    bool isNotLastPage = state.sightsModel.next != null;

    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollInfo) {
        scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
                isNotLastPage
            ? context.read<SightsBloc>().add(SightsLoadEvent())
            : null;
        return true;
      },
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.sightsModel.results?.length,
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
    SightsLoaded state, //
    int index, //top:   search
    double height, // top :  search:250
    double width, // top :250  search:
    final EdgeInsetsGeometry padding,
  ) {
    Result result = state.sightsModel.results![index];
    return Padding(
      padding: padding,
      //padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AttractionPostScreen(
                results: result,
              ),
            ),
          ).then((value) => setState(() {
                state.sightsModel.results![index].isFavorite;
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
                          .deleteFavoritesVisualisationSights(result.id ?? -1);

                      if (isDeleted) {
                        setState(() {
                          state.sightsModel.results![index].isFavorite = false;
                        });
                      }
                      return;
                    } else {
                      bool isPosted = await FavoritesRepository
                          .postFavoritesVisualisationSights(result.id ?? -1);

                      if (isPosted) {
                        setState(() {
                          state.sightsModel.results![index].isFavorite = true;
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
}
