import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HotelStore {
  // values: 1.hotels location
  //        2.hotels favourite icon = red or black
  //        3.hotels photos
  //        4.hotels stars
  //        5.hotels price
  //        6.hotels description

  // all informations about hotel:----------------------------------------------
  static Map<String, List<String>> mapHotelInformation = {
    'Sheraton Bishkek': [
      // key: hotels name
      'Bishkek, Kyrgyzstan', // 0.hotels loacation
      'f', // 1.hotel = favourite or unfavourite
      'images/hotels/sheraton_bishkek/', // 2.hotels photos
      '4.3*', // 3.hotels star
      '\$450 / Night', // 4.hotels price
      'Sheraton Bishkek features free bikes, terrace, a restaurant and bar in Bishkek. This 5-star hotel offers a concierge service and luggage storage space. The accommodation provides a 24-hour front desk, airport transfers, room service and free Wi-Fi throughout the property.' // hotels description
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

  // method which counts images in folder:--------------------------------------
  Future<int> countFilesInFolder(String path) async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assetPaths = assetManifest
        .listAssets()
        .where((String key) => key.startsWith(path))
        .toList();

    debugPrint('Number of files in the $path folder: ${assetPaths.length}');
    return assetPaths.length - 1; // -1 because HotelDoor.jpg
  }
  //
}
