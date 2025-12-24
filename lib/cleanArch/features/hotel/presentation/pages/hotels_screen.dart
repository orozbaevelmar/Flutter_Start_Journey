import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/CleanArch/core/constants/navigator_custom.dart';
import 'package:start_journey/CleanArch/features/hotel/presentation/widgets/attraction_card.dart';
import 'package:start_journey/cleanArch/core/common/entity/places_entity.dart';
import 'package:start_journey/cleanArch/core/common/widgets/widgetssss/app_bar.dart';
import 'package:start_journey/cleanArch/core/common/widgets/widgetssss/empty_list.dart';
import 'package:start_journey/cleanArch/core/common/widgets/widgetssss/search_text_field.dart';
import 'package:start_journey/cleanArch/core/common/widgets/widgetssss/tag_line.dart';
import 'package:start_journey/cleanArch/core/extensions/context_extension.dart';
import 'package:start_journey/cleanArch/features/home/presentation/pages/home_categories/components/categories.dart';
import 'package:start_journey/cleanArch/features/home/presentation/pages/home_categories/components/mini_attraction.dart';
import 'package:start_journey/cleanArch/features/hotel/presentation/bloc/hotel/hotel_bloc.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  @override
  void initState() {
    context.read<HotelBloc>().add(HotelLoadEvent(isInitial: true));
    super.initState();
  }

  void _searchResult(String newQuery) {
    setState(() {
      _searchController;
    });
    if (newQuery.isEmpty) {
      context.read<HotelBloc>().add(HotelLoadEvent(isInitial: true));
      return;
    }
    context
        .read<HotelBloc>()
        .add(HotelSearchEvent(isInitial: true, hotelsNameContains: newQuery));
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
    final appTheme = context.startJourneyTheme;
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
                fontSizeBig: fontSizeBig, hintText: 'Hotels for all Desires'),
            CustomSearchTextField(
              hintText: 'Search for Hotels',
              fontSize: fontSizeSmall,
              controller: _searchController,
              onTapClearIcon: () {
                setState(() => _searchController.clear());
                context.read<HotelBloc>().add(HotelAfterClearingSearchField());
              },
              onChanged: _searchResult,
            ),
            _searchController.text.isEmpty
                ? Column(
                    children: [
                      _hotelsTopLocatedOfScreen1(),
                      CustomFilterAttraction(
                          fontSizeSmall: fontSizeSmall, yourWishes: yourWishes),
                      MiniAttractionAtBottom(
                        fontSizeMedium: fontSizeMedium,
                        photo: 'images/hotels/sheraton_bishkek/hotel0.jpg',
                      )
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
      child: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          return switch (state) {
            HotelLoaded() => _buildSearcListView(state),
            HotelLoading() ||
            HotelInitial() =>
              const Center(child: CircularProgressIndicator()),
            HotelEmpty() => EmptyListy(text: state.message),
            HotelInitialError() => Center(child: Text(state.message)),
          };
        },
      ),
    );
  }

  Widget _buildSearcListView(HotelLoaded state) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: state.hotelistModel.results?.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        PlacesEntity result =
            state.hotelistModel.results?[index] ?? PlacesEntity();
        return AttractionCard(
          result: result,
          height: 250,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          fontSizeMedium: fontSizeMedium,
          fontSizeSmall: fontSizeSmall,
        );
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
              HotelLoading() ||
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
    bool isNotLastPage = state.hotelistModel.next != null;

    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollInfo) {
        scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
                isNotLastPage
            ? context.read<HotelBloc>().add(HotelLoadEvent(isInitial: false))
            : null;
        return true;
      },
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.hotelistModel.results?.length,
              itemBuilder: (context, index) {
                PlacesEntity result =
                    state.hotelistModel.results?[index] ?? PlacesEntity();
                return AttractionCard(
                  result: result,
                  height: double.infinity,
                  width: 250,
                  padding: const EdgeInsets.only(right: 20),
                  fontSizeMedium: fontSizeMedium,
                  fontSizeSmall: fontSizeSmall,
                );
              },
            ),
          ),
          if (state.loadingMore?.errorMessage != null)
            const Center(
              child: Text('On load more error'),
            ),
          if (state.loadingMore?.isLoading ?? false)
            const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
