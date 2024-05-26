import 'dart:convert';

import 'package:start_journey/repository/response_body/response_body_hotel.dart';

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
        (favoriteFetchedDataVisualisation['results'] as List).add(
            HowLooksFetchedDataHotel.fetchedDataVisualisation2['results'][i]);
      }
    }
    final String result = json.encode(favoriteFetchedDataVisualisation);
    return result;
  }
}
