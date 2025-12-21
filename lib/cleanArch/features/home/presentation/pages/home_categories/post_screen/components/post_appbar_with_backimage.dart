import 'package:flutter/material.dart';
import 'package:start_journey/cleanArch/core/common/entity/places_entity.dart';
import 'package:start_journey/old_stuffs/repository/favorites.dart';

class PostAppBarWithBackgroundImage extends StatefulWidget {
  const PostAppBarWithBackgroundImage({
    super.key,
    required this.result,
  });
  final PlacesEntity result;

  @override
  State<PostAppBarWithBackgroundImage> createState() =>
      _PostAppBarWithBackgroundImageState();
}

class _PostAppBarWithBackgroundImageState
    extends State<PostAppBarWithBackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.result.photos?[0].photo ?? ''),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
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
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 25,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
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
                    child: widget.result.isFavorite ?? false
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 25,
                          )
                        : Icon(
                            Icons.favorite_outline_outlined,
                            color: Colors.black,
                            size: 25,
                          ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
