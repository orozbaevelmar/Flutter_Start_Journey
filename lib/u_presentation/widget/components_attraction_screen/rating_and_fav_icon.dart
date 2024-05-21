import 'package:flutter/material.dart';

class RatingAndFavoriteIcon extends StatefulWidget {
  final VoidCallback onTapChangeFavoriteIcon;
  final String rating;
  final bool isFavorite;
  const RatingAndFavoriteIcon({
    Key? key,
    required this.rating,
    required this.isFavorite,
    required this.onTapChangeFavoriteIcon,
  }) : super(key: key);

  @override
  State<RatingAndFavoriteIcon> createState() => _RatingAndFavoriteIconState();
}

class _RatingAndFavoriteIconState extends State<RatingAndFavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.rating,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),

        // Favourite Icon
        InkWell(
          onTap: widget.onTapChangeFavoriteIcon,
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
            child: widget.isFavorite
                //_favouriteStore.checkRedFavouriteIcon(mapKey)
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
    );
  }
}
