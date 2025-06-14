import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/components/rating_and_fav_icon.dart';

class MiniAttractionAtBottom extends StatelessWidget {
  final String photo;
  const MiniAttractionAtBottom({
    super.key,
    required this.fontSizeMedium,
    required this.photo,
  });

  final double fontSizeMedium;

  @override
  Widget build(BuildContext context) {
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
                      image: AssetImage(photo),
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
