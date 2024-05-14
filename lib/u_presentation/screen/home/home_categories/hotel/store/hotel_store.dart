import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:start_journey/model/hotel.dart';
import 'package:start_journey/u_presentation/screen/home/home_categories/hotel/hotel_post_screen.dart';
import 'package:start_journey/utils/store_abstract_class/attraction.dart';

class HotelStore implements Attraction {
  /* static List<String> hotelsName = [
    'Sheraton Bishkek',
    'Grand Hotel',
    'Jannat Resort',
    'Rayan Hotel',
    'TES Hotel',
  ]; */

  // key: Hotel's name
  // values: 1.hotels location
  //        2.hotels favourite icon = red or outlined
  //        3.hotels photos
  //        4.hotels stars
  //        5.hotels price
  //        6.hotels description

  // all informations about hotel:----------------------------------------------

  static final Map<String, List<String>> _mapInformation = {
    'Sheraton Bishkek': [
      // key: hotels name
      'Bishkek, Kyrgyzstan', // 0.hotels loacation
      'u', // 1.hotel = favourite or unfavourite respectively 'f' and 'u'
      'images/hotels/sheraton_bishkek/', // 2.hotels photos
      '4.3*', // 3.hotels star
      '\$450 / Night', // 4.hotels price
      'Sheraton Bishkek features free bikes, terrace, a restaurant and bar in Bishkek. This 5-star hotel offers a concierge service and luggage storage space. The accommodation provides a 24-hour front desk, airport transfers, room service and free Wi-Fi throughout the property.' // hotels description
      // 5.hotel's description
    ],
    'Jannat Resort': [
      'Osh, Kyrgyzstan',
      'u',
      'images/hotels/jannat_resort/',
      '5*',
      '\$100000 / Night',
      'Jannat Resort is beautiful place',
    ],
  };

  @override
  void changeFavouriteIconToRed(String mapKey) {
    _mapInformation[mapKey]?[1] = 'f';
  }

  @override
  void changeFavouriteIconToOutlined(String mapKey) {
    _mapInformation[mapKey]?[1] = 'u';
  }

  @override
  Map<String, List<String>> get getMapInformation => _mapInformation;

  /* void changeFavouriteIcon(String favouriteElement) {
    _mapInformation[favouriteElement]?[1] = 'f';
  } */

  // favouriteMap == key: favourite element's name
  //               value: [0]=HotelStore
  //                      [1]=HotelPostScreen

  @override
  dynamic getPostScreen(String mapkey) {
    return HotelPostScreen(
      results: Results(),
    );
  }

  @override
  String getDescription(String favouriteElementsName) {
    return _mapInformation[favouriteElementsName]?.elementAt(5) ??
        'It may need fixes';
  }

  @override
  String getPrice(String favouriteElementsName) {
    return _mapInformation[favouriteElementsName]?.elementAt(4) ??
        'It may need fixes';
  }

  @override
  String getRating(String favouriteElementsName) {
    return _mapInformation[favouriteElementsName]?.elementAt(3) ??
        'It may need fixes';
  }

  @override
  String getPictureOfFacade(String favouriteElementsName) {
    return '${_mapInformation[favouriteElementsName]?.elementAt(2)}hotelDoor.jpg';
  }

  @override
  String getPictures(String favouriteElementsName) {
    return _mapInformation[favouriteElementsName]?.elementAt(2) ??
        'It may need Fixes';
  }

  @override
  String getLocation(String favouriteElementsName) {
    return _mapInformation[favouriteElementsName]?.elementAt(0) ??
        'It may need Fixes';
  }

  // method which counts images in folder:--------------------------------------
  Future<int> countFilesInFolder(String path) async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assetPaths = assetManifest
        .listAssets()
        .where((String key) => key.startsWith(path))
        .toList();

    debugPrint('Number of files in the $path folder: ${assetPaths.length}');
    return assetPaths.length - 1; // -1 because of HotelDoor.jpg in images
  }

  static String queryHotel = '';

  void onQueryChangedHotel(String newQuery) {
    queryHotel = newQuery;
  }

  static List<String> searchResultsList = [];

  void searchResultHotel(String newQuery) {
    queryHotel = newQuery;

    searchResultsList = _mapInformation.keys
        .where((item) => item.toLowerCase().contains(queryHotel.toLowerCase()))
        .toList();
  }

  @override
  String showImageOnTap(String nameOfElement, int indexOfImage) {
    return '${_mapInformation[nameOfElement]?.elementAt(2) ?? 'It may need fixes'}hotel$indexOfImage.jpg';
  }
}
