import 'dart:convert';

class HowLooksFetchedDataSights {
  static String get fetchedResponseBodyVisualisation =>
      json.encode(fetchedDataVisualisation);

  // rating should be double
  static final Map<String, dynamic> fetchedDataVisualisation = {
    "count": 2,
    "next": null, //<MString.BASE_URL>/hotels/?page=2
    "previous": null,
    "results": [
      {
        "id": 1,
        "name": 'Ruh Ordo',
        "location": 'Ysyk-Kol, Kyrgyzstan',
        "is_favorite": false,
        "rating": 5.5,
        "price": '\$234 / Night',
        "description":
            'Ruh Ordo, nestled along the shores of Lake Issyk-Kul in Cholpon-Ata, Kyrgyzstan, is a cultural and spiritual center founded by Askar Akayev, the country\'s first president. The name, meaning "Spiritual Center" in Kyrgyz, reflects its purpose of promoting cultural diversity and religious harmony.',
        "photos": [
          {"id": 1, "photo": "images/sights/ruh_ordo/sightsDoor.jpg"},
          {"id": 2, "photo": "images/sights/ruh_ordo/sights0.jpg"},
        ],
      },
      {
        "id": 2,
        "name": 'Canyon Fairy Tale',
        "location": 'Ysyk-Kol, Kyrgyzstan',
        "is_favorite": false,
        "rating": 5.6,
        "price": '\$1000 / Night',
        "description":
            'It gets its name from the fantasy-like shapes carved into the red sandstone from centuries of wind and water. You can see dragons, snakes, castles, and whatever else your mind’s eye can see. It’s located on the southern side of Issyk-Kul Lake, between Kaji-Say and Tosor. Mid-way between the east and west side of the lake.',
        "photos": [
          {"id": 3, "photo": "images/sights/canyon_fairy_tale/sightsDoor.jpg"},
          {"id": 4, "photo": "images/sights/canyon_fairy_tale/sights0.jpg"},
        ],
      },
    ],
  };

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

  bool setFalseFavoriteIcon(int hotelId) {
    if (hotelId > -1) {
      for (int i = 0; i < fetchedDataVisualisation['results'].length; i++) {
        if (fetchedDataVisualisation['results'][i]['id'] == hotelId) {
          fetchedDataVisualisation['results'][i]['is_favorite'] = false;

          return true;
        }
      }
    }
    return false;
  }

  bool setTrueFavoriteIcon(int hotelId) {
    if (hotelId > -1) {
      for (int i = 0; i < fetchedDataVisualisation['results'].length; i++) {
        if (fetchedDataVisualisation['results'][i]['id'] == hotelId) {
          fetchedDataVisualisation['results'][i]['is_favorite'] = true;

          return true;
        }
      }
    }
    return false;
  }

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

  static String searchCompleted(String wordContains) {
    final Map<String, dynamic> searchedFetchedDataVisualisation = {
      "count": 2,
      "next": null,
      "previous": null,
      "results": [],
    };

    for (int i = 0; i < fetchedDataVisualisation['results'].length; i++) {
      if ((fetchedDataVisualisation['results'][i]['name'] as String)
          .toLowerCase()
          .contains(wordContains.toLowerCase())) {
        (searchedFetchedDataVisualisation['results'] as List)
            .add(fetchedDataVisualisation['results'][i]);
      }
    }

    final String result = json.encode(searchedFetchedDataVisualisation);
    return result;
  }

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

  static String favoriteData() {
    final Map<String, dynamic> favoriteFetchedDataVisualisation = {
      "count": 2,
      "next": null,
      "previous": null,
      "results": [],
    };

    for (int i = 0; i < fetchedDataVisualisation['results'].length; i++) {
      if ((fetchedDataVisualisation['results'][i]['is_favorite'] as bool) ==
          true) {
        (favoriteFetchedDataVisualisation['results'] as List)
            .add(fetchedDataVisualisation['results'][i]);
      }
    }

    final String result = json.encode(favoriteFetchedDataVisualisation);
    return result;
  }
}
