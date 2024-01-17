import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:start_journey/home_categories/sights/sights_post_screen.dart';
import 'package:start_journey/home_categories/store_abstract_class/attraction.dart';

class SightsStore implements Attraction {
  static final Map<String, List<String>> _mapSightsInformation = {
    'Ruh Ordo': [
      // key: hotels name
      'Yssyk-Kol, Kyrgyzstan', // 0.hotels loacation
      'u', // 1.hotel = favourite or unfavourite respectively 'f' and 'u'
      'images/sights/ruh_ordo/', // 2.hotels photos
      '2.2*', // 3.hotels star
      '\$0 / Night', // 4.hotels price
      'Ruh Ordo, nestled along the shores of Lake Issyk-Kul in Cholpon-Ata, Kyrgyzstan, is a cultural and spiritual center founded by Askar Akayev, the country\'s first president. The name, meaning "Spiritual Center" in Kyrgyz, reflects its purpose of promoting cultural diversity and religious harmony.' // hotels description
      // 5.hotel's description
    ],
    'Uzgen Minaret Tower': [
      'Osh, Kyrgyzstan',
      'u',
      'images/sights/uzgen_minaret_tower/',
      '2.1*',
      '\$1000 / Night',
      'Jannat Resort is beautiful place',
    ],
  };

  @override
  Map<String, List<String>> get getMapInformation => _mapSightsInformation;

  @override
  dynamic getPostScreen = SightsPostScreen;

  @override
  void changeFavouriteIconToRed(String mapKey) {
    _mapSightsInformation[mapKey]?[1] = 'f';
  }

  @override
  void changeFavouriteIconToOutlined(String mapKey) {
    _mapSightsInformation[mapKey]?[1] = 'u';
  }

  @override
  String getDescription(String favouriteElementsName) {
    return _mapSightsInformation[favouriteElementsName]?.elementAt(5) ??
        'It may need fixes';
  }

  @override
  String getPrice(String favouriteElementsName) {
    return _mapSightsInformation[favouriteElementsName]?.elementAt(4) ??
        'It may need fixes';
  }

  @override
  String getRating(String favouriteElementsName) {
    return _mapSightsInformation[favouriteElementsName]?.elementAt(3) ??
        'It may need fixes';
  }

  @override
  String getPictureOfFacade(String favouriteElementsName) {
    return '${_mapSightsInformation[favouriteElementsName]?.elementAt(2)}sightsDoor.jpg';
  }

  @override
  String getPictures(String favouriteElementsName) {
    return _mapSightsInformation[favouriteElementsName]?.elementAt(2) ??
        'It may need Fixes';
  }

  @override
  String getLocation(String favouriteElementsName) {
    return _mapSightsInformation[favouriteElementsName]?.elementAt(0) ??
        'It may need Fixes';
  }

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

    searchResultsListSights = SightsStore._mapSightsInformation.keys
        .where((item) => item.toLowerCase().contains(querySights.toLowerCase()))
        .toList();
  }
}
