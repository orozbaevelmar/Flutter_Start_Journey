import 'package:flutter/material.dart';
import 'package:start_journey/old_stuffs/model/extra/photo.dart';
import 'package:start_journey/old_stuffs/model/extra/results.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/post_screen/components/post_amenities.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/post_screen/components/post_appbar_with_backimage.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/post_screen/components/post_description.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/post_screen/components/post_name.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_categories/post_screen/components/post_price_and_booking.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/home/home_regions/region_post_screen.dart';
import 'package:start_journey/old_stuffs/u_presentation/widget/show_image_on_tap.dart';
import 'package:start_journey/old_stuffs/utils/constants/navigator_custom.dart';

class RegionsScreen extends StatelessWidget {
  final String photo;
  final String name;
  RegionsScreen({
    super.key,
    required this.photo,
    required this.name,
  });

  String description =
      'Located in the northeast of Kyrgyzstan, Issyk Kul Lake or Yssyk-Kol is a must-see in Kyrgyzstan. It ranks as the second largest lake of Central Asia, the second largest saline lake in the world and the seventh deepest lake. This place attracts numerous tourists with its magnificent equestrian and pedestrian itineraries in the surrounding mountains and its beautiful background of towering white summits.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Go.to(context, RegionPostScreen(name: name, photo: photo));
        },
        child: PriceAndBooking(price: '\$500 / Night'),
      ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          PostAppBarWithBackgroundImage(
            result: Result(photos: [Photos(id: 1, photo: photo)]),
          ),
          _buildPostInformation(),
        ],
      ),
    );
  }

  Widget _buildPostInformation() {
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
          PostName(attractionName: name ?? ''),
          Amenities(),
          PostDescription(
            description: description ?? '',
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
            itemCount: 1,
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
                        photos: [Photos(id: 1, photo: photo)],
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
                      image: AssetImage(photo),
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
