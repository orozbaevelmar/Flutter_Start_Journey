import 'package:flutter/material.dart';
import 'package:start_journey/moveToCleanArch/core/common/entity/places_entity.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/post_screen/attraction_post_screen.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/components/name_and_location.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/components/rating_and_fav_icon.dart';

class AttractionCard extends StatefulWidget {
  final PlacesEntity result; //
  final double height; // top :  search:250
  final double width; // top :250  search:
  final EdgeInsetsGeometry padding;
  final double fontSizeMedium;
  final double fontSizeSmall;
  const AttractionCard({
    super.key,
    required this.result,
    required this.height,
    required this.width,
    required this.padding,
    required this.fontSizeMedium,
    required this.fontSizeSmall,
  });

  @override
  State<AttractionCard> createState() => _AttractionCardState();
}

class _AttractionCardState extends State<AttractionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      //padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AttractionPostScreen(
                results: widget.result,
              ),
            ),
          ).then((value) => setState(() {
                widget.result.isFavorite;
              }));
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          //width: 250,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(
                widget.result.photos?[0].photo ?? '',
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
                  rating: widget.result.rating.toString(),
                  isFavorite: widget.result.isFavorite ?? false,
                  onTapChangeFavoriteIcon: () async {
                    // if (widget.result.isFavorite ?? false) {
                    //   bool isDeleted = await FavoritesRepository
                    //       .deleteFavoritesVisualisationHotel(
                    //           widget.result.id ?? -1);

                    //   if (isDeleted) {
                    //     setState(() {
                    //       widget.result.isFavorite = false;
                    //     });
                    //   }
                    //   return;
                    // } else {
                    //   bool isPosted = await FavoritesRepository
                    //       .postFavoritesVisualisationHotel(
                    //           widget.result.id ?? -1);

                    //   if (isPosted) {
                    //     setState(() {
                    //       widget.result.isFavorite = true;
                    //     });
                    //   }
                    // }
                  },
                ),
                AttractionNameAndLocation(
                  fontSizeMedium: widget.fontSizeMedium,
                  fontSizeSmall: widget.fontSizeSmall,
                  location: widget.result.location ?? '',
                  name: widget.result.name ?? '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
