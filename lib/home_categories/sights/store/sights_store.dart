import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SightsStore {
  static final Map<String, List<String>> mapSightsInformation = {
    'Ruh Ordo': [
      // key: hotels name
      'Yssyk-Kol, Kyrgyzstan', // 0.hotels loacation
      'u', // 1.hotel = favourite or unfavourite respectively 'f' and 'u'
      'images/sights/ruh_ordo/', // 2.hotels photos
      '4.3*', // 3.hotels star
      '\$0 / Night', // 4.hotels price
      'Ruh Ordo, nestled along the shores of Lake Issyk-Kul in Cholpon-Ata, Kyrgyzstan, is a cultural and spiritual center founded by Askar Akayev, the country\'s first president. The name, meaning "Spiritual Center" in Kyrgyz, reflects its purpose of promoting cultural diversity and religious harmony.' // hotels description
      // 5.hotel's description
    ],
    'Uzgen Minaret Tower': [
      'Osh, Kyrgyzstan',
      'u',
      'images/sights/uzgen_minaret_tower/',
      '5*',
      '\$1000 / Night',
      'Jannat Resort is beautiful place',
    ],
  };

  Future<int> countFilesInFolder(String path) async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assetPaths = assetManifest
        .listAssets()
        .where((String key) => key.startsWith(path))
        .toList();

    debugPrint('Number of files in the $path folder: ${assetPaths.length}');
    return assetPaths.length - 1; // -1 because of HotelDoor.jpg in images
  }

  static String querySights = '';

  void onQueryChangedSights(String newQuery) {
    querySights = newQuery;
  }

  static List<String> searchResultsListSights = [];

  void searchResultSights(String newQuery) {
    querySights = newQuery;

    searchResultsListSights = SightsStore.mapSightsInformation.keys
        .where((item) => item.toLowerCase().contains(querySights.toLowerCase()))
        .toList();
  }
}
