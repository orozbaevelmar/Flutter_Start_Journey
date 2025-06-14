import 'package:flutter/material.dart';
import 'package:start_journey/old_stuffs/bloc/hotel/bloc.dart';
import 'package:start_journey/old_stuffs/model/extra/results.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/components/attraction_card.dart';
import 'package:start_journey/old_stuffs/u_presentation/widget/app_bar.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/components/categories.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/components/mini_attraction.dart';
import 'package:start_journey/old_stuffs/u_presentation/widget/empty_list.dart';
import 'package:start_journey/old_stuffs/u_presentation/widget/search_text_field.dart';
import 'package:start_journey/old_stuffs/u_presentation/widget/tag_line.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/old_stuffs/utils/constants/navigator_custom.dart';

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
    if (newQuery.isEmpty) {
      context.read<HotelBloc>().add(HotelLoadEvent());
      return;
    }
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
              backButtonPressed: () => Go.back(context),
            ),
            CustomTagLine(
                fontSizeBig: fontSizeBig, hintText: 'Hotels for all Desires'),
            CustomSearchTextField(
              hintText: 'Search for Hotels',
              fontSize: fontSizeSmall,
              controller: _searchController,
              onTap: () {
                setState(() => _searchController.clear());
                context.read<HotelBloc>().add(HotelLoadEvent());
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
        Result result = state.hotelsModel.results![index];
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
                Result result = state.hotelsModel.results![index];
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
          if (state.error != null)
            const Center(
              child: Text('On load more error'),
            ),
          if (state.loading != null) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
