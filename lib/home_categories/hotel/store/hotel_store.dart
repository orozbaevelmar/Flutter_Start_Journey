import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HotelStore {
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
  static final Map<String, List<String>> mapInformation = {
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
      '\$1000 / Night',
      'Jannat Resort is beautiful place',
    ],
  };

  // favouriteMap == key: favourite element's name
  //               value: [0]=HotelStore
  //                      [1]=HotelPostScreen

  String getDescription(String favouriteElementsName) {
    return mapInformation[favouriteElementsName]?.elementAt(5) ??
        'It may need fixes';
  }

  String getPrice(String favouriteElementsName) {
    return mapInformation[favouriteElementsName]?.elementAt(4) ??
        'It may need fixes';
  }

  String getRating(String favouriteElementsName) {
    return mapInformation[favouriteElementsName]?.elementAt(3) ??
        'It may need fixes';
  }

  String getPictureOfFacade(String favouriteElementsName) {
    return '${mapInformation[favouriteElementsName]?.elementAt(2)}hotelDoor.jpg';
  }

  String getPictures(String favouriteElementsName) {
    return mapInformation[favouriteElementsName]?.elementAt(2) ??
        'It may need Fixes';
  }

  String getLocation(String favouriteElementsName) {
    return mapInformation[favouriteElementsName]?.elementAt(0) ??
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

    searchResultsList = HotelStore.mapInformation.keys
        .where((item) => item.toLowerCase().contains(queryHotel.toLowerCase()))
        .toList();
  }
}
