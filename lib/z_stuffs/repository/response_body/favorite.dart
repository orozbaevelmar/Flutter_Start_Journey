import 'dart:convert';

import 'package:start_journey/z_stuffs/repository/response_body/response_body_hotel.dart';
import 'package:start_journey/z_stuffs/repository/response_body/response_body_sights.dart';

class FavoriteData {
  static String favoriteData() {
    final Map<String, dynamic> favoriteFetchedDataVisualisation = {
      "count": 2,
      "next": null,
      "previous": null,
      "results": [],
    };

    for (int i = 0;
        i < HowLooksFetchedDataHotel.fetchedDataVisualisation['results'].length;
        i++) {
      if ((HowLooksFetchedDataHotel.fetchedDataVisualisation['results'][i]
              ['is_favorite'] as bool) ==
          true) {
        print(
            "HOTEL1 ===${HowLooksFetchedDataHotel.fetchedDataVisualisation['results'][i]['name']}");
        (favoriteFetchedDataVisualisation['results'] as List).add(
            HowLooksFetchedDataHotel.fetchedDataVisualisation['results'][i]);
      }
    }

    for (int i = 0;
        i <
            HowLooksFetchedDataHotel
                .fetchedDataVisualisation2['results'].length;
        i++) {
      if ((HowLooksFetchedDataHotel.fetchedDataVisualisation2['results'][i]
              ['is_favorite'] as bool) ==
          true) {
        print(
            "HOTEL2 ===${HowLooksFetchedDataHotel.fetchedDataVisualisation2['results'][i]['name']}");
        (favoriteFetchedDataVisualisation['results'] as List).add(
            HowLooksFetchedDataHotel.fetchedDataVisualisation2['results'][i]);
      }
    }

    int lenSights =
        HowLooksFetchedDataSights.fetchedDataVisualisation['results'].length;
    for (int i = 0; i < lenSights; i++) {
      bool isFav = (HowLooksFetchedDataSights
          .fetchedDataVisualisation['results'][i]['is_favorite'] as bool);
      if (isFav == true) {
        print(
            "Sights ===${HowLooksFetchedDataSights.fetchedDataVisualisation['results'][i]['name']}");
        (favoriteFetchedDataVisualisation['results'] as List).add(
            HowLooksFetchedDataSights.fetchedDataVisualisation['results'][i]);
      }
    }
    final String result = json.encode(favoriteFetchedDataVisualisation);
    return result;
  }
}
