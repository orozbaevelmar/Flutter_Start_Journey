import 'package:flutter/material.dart';
import 'package:start_journey/model/extra/results.dart';
import 'package:start_journey/u_presentation/screen/home/home_categories/post_screen/components/post_amenities.dart';
import 'package:start_journey/u_presentation/screen/home/home_categories/post_screen/components/post_appbar_with_backimage.dart';
import 'package:start_journey/u_presentation/screen/home/home_categories/post_screen/components/post_description.dart';
import 'package:start_journey/u_presentation/screen/home/home_categories/post_screen/components/post_name.dart';
import 'package:start_journey/u_presentation/screen/home/home_categories/post_screen/components/post_price_and_booking.dart';
import 'package:start_journey/u_presentation/widget/show_image_on_tap.dart';

class AttractionPostScreen extends StatelessWidget {
  final Result results;

  const AttractionPostScreen({
    super.key,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: PriceAndBooking(price: results.price ?? ''),
    );
  }

  // build body:----------------------------------------------------------------
  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          PostAppBarWithBackgroundImage(
            result: results,
          ),
          _buildPostInformation(context),
        ],
      ),
    );
  }

  // build post information:----------------------------------------------------
  Widget _buildPostInformation(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 380),
      decoration: BoxDecoration(
        color: Colors.white,
        //color: Color.fromRGBO(191, 191, 191, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildPostRoomImages(),
          PostName(attractionName: results.name ?? ''),
          Amenities(),
          PostDescription(
            description: results.description ?? '',
          )
        ],
      ),
    );
  }

  Widget _buildPostRoomImages() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(20),
          child: Text(
            'See All Room',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 2),
          height: 100,
          child: ListView.builder(
            itemCount: results.photos?.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowImageOnTap(
                        index: index,
                        photos: results.photos ?? [],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        results.photos?[index].photo ?? '',
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
