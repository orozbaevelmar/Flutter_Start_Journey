import 'dart:convert';

class HowLooksFetchedData {
  final howLooksJsonFormatDataInReality = {
    "count": 10,
    "next": "<MString.BASE_URL>/hotels/?page=2",
    "previous": null,
    "results": [
      {
        "id": 1,
        "name": 'Sheraton Bishkek',
        "location": 'Bishkek, Kyrgyzstan',
        "is_favorite": true,
        "rating": 4.3,
        "price": '\$450 / Night',
        "description":
            'Sheraton Bishkek features free bikes, terrace, a restaurant and bar in Bishkek. This 5-star hotel offers a concierge service and luggage storage space. The accommodation provides a 24-hour front desk, airport transfers, room service and free Wi-Fi throughout the property.',
        "photos": [
          {
            "id": 1,
            "photo":
                "<MString.BASE_URL>/media/images/hotels/%D0%BE%D0%B1%D0%BE%D0%B8.webp"
          },
          {
            "id": 2,
            "photo":
                "<MString.BASE_URL>/media/images/hotels/%D0%BE%D0%B1%D0%BE%D0%B8_7gpH78s.webp"
          },
        ],
      },
      {
        "id": 2,
        "name": 'Jannat Resort',
        "location": 'Osh, Kyrgyzstan',
        "is_favorite": true,
        "rating": 5,
        "price": '\$100000 / Night',
        "description":
            'The Jannat Resort mountain hotel is the pearl of the Jannat hotel collection.  The opening of this hotel was of paramount importance, as the hotel is unique to Kyrgyzstan.  The hotel is located 20 km from Bishkek, famous for its underground mineral water sources, clean mountain air and the picturesque surroundings of the village of Koi-Tash. Beautiful views of the mountains, elegant architecture and magnificent interior create an atmosphere of wonderful rest.  Each window offers a breathtaking view of the majestic mountains and the colorful river of the Alamedin gorge.',
        "photos": [
          {
            "id": 3,
            "photo":
                "<MString.BASE_URL>/media/images/hotels/%D0%BE%D0%B1%D0%BE%D0%B8.webp"
          },
          {
            "id": 4,
            "photo":
                "<MString.BASE_URL>/media/images/hotels/%D0%BE%D0%B1%D0%BE%D0%B8_7gpH78s.webp"
          },
        ],
      },
    ],
  };

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
  static final String fetchedResponseBodyVisualisation =
      json.encode(_fetchedDataVisualisation);

  // rating should be double
  static final Map<String, dynamic> _fetchedDataVisualisation = {
    "count": 2,
    "next":
        _fetchedResponseBodyVisualisation2, //<MString.BASE_URL>/hotels/?page=2
    "previous": null,
    "results": [
      {
        "id": 1,
        "name": 'Sheraton Bishkek',
        "location": 'Bishkek, Kyrgyzstan',
        "is_favorite": true,
        "rating": 4.3,
        "price": '\$450 / Night',
        "description":
            'Sheraton Bishkek features free bikes, terrace, a restaurant and bar in Bishkek. This 5-star hotel offers a concierge service and luggage storage space. The accommodation provides a 24-hour front desk, airport transfers, room service and free Wi-Fi throughout the property.',
        "photos": [
          {"id": 1, "photo": "images/hotels/sheraton_bishkek/hotelDoor.jpg"},
          {"id": 2, "photo": "images/hotels/sheraton_bishkek/hotel0.jpg"},
          {"id": 3, "photo": "images/hotels/sheraton_bishkek/hotel1.jpg"},
          {"id": 4, "photo": "images/hotels/sheraton_bishkek/hotel2.jpg"},
          {"id": 5, "photo": "images/hotels/sheraton_bishkek/hotel3.jpg"},
          {"id": 6, "photo": "images/hotels/sheraton_bishkek/hotel4.jpg"},
          {"id": 7, "photo": "images/hotels/sheraton_bishkek/hotel5.jpg"},
          {"id": 8, "photo": "images/hotels/sheraton_bishkek/hotel6.jpg"},
          {"id": 9, "photo": "images/hotels/sheraton_bishkek/hotel7.jpg"},
        ],
      },
      {
        "id": 2,
        "name": 'Jannat Resort',
        "location": 'Osh, Kyrgyzstan',
        "is_favorite": true,
        "rating": 5.0,
        "price": '\$100000 / Night',
        "description":
            'The Jannat Resort mountain hotel is the pearl of the Jannat hotel collection.  The opening of this hotel was of paramount importance, as the hotel is unique to Kyrgyzstan.  The hotel is located 20 km from Bishkek, famous for its underground mineral water sources, clean mountain air and the picturesque surroundings of the village of Koi-Tash. Beautiful views of the mountains, elegant architecture and magnificent interior create an atmosphere of wonderful rest.  Each window offers a breathtaking view of the majestic mountains and the colorful river of the Alamedin gorge.',
        "photos": [
          {"id": 10, "photo": "images/hotels/jannat_resort/hotelDoor.jpg"},
          {"id": 11, "photo": "images/hotels/jannat_resort/hotel0.jpg"},
          {"id": 12, "photo": "images/hotels/jannat_resort/hotel1.jpg"},
          {"id": 13, "photo": "images/hotels/jannat_resort/hotel2.jpg"},
          {"id": 14, "photo": "images/hotels/jannat_resort/hotel3.jpg"},
        ],
      },
    ],
  };

  static final String _fetchedResponseBodyVisualisation2 =
      json.encode(_fetchedDataVisualisation2);

  static final Map<String, dynamic> _fetchedDataVisualisation2 = {
    "count": 2,
    "next": null,
    "previous": null,
    "results": [
      {
        "id": 3,
        "name": 'Ilim Hotel',
        "location": 'Bishkek, Kyrgyzstan',
        "is_favorite": true,
        "rating": 4.3,
        "price": '\$450 / Night',
        "description":
            'Sheraton Bishkek features free bikes, terrace, a restaurant and bar in Bishkek. This 5-star hotel offers a concierge service and luggage storage space. The accommodation provides a 24-hour front desk, airport transfers, room service and free Wi-Fi throughout the property.',
        "photos": [
          {"id": 1, "photo": "images/hotels/sheraton_bishkek/hotelDoor.jpg"},
          {"id": 2, "photo": "images/hotels/sheraton_bishkek/hotel0.jpg"},
          {"id": 3, "photo": "images/hotels/sheraton_bishkek/hotel1.jpg"},
          {"id": 4, "photo": "images/hotels/sheraton_bishkek/hotel2.jpg"},
          {"id": 5, "photo": "images/hotels/sheraton_bishkek/hotel3.jpg"},
          {"id": 6, "photo": "images/hotels/sheraton_bishkek/hotel4.jpg"},
          {"id": 7, "photo": "images/hotels/sheraton_bishkek/hotel5.jpg"},
          {"id": 8, "photo": "images/hotels/sheraton_bishkek/hotel6.jpg"},
          {"id": 9, "photo": "images/hotels/sheraton_bishkek/hotel7.jpg"},
        ],
      },
      {
        "id": 4,
        "name": 'Bilim Hotel',
        "location": 'Osh, Kyrgyzstan',
        "is_favorite": true,
        "rating": 5.0,
        "price": '\$100000 / Night',
        "description":
            'The Jannat Resort mountain hotel is the pearl of the Jannat hotel collection.  The opening of this hotel was of paramount importance, as the hotel is unique to Kyrgyzstan.  The hotel is located 20 km from Bishkek, famous for its underground mineral water sources, clean mountain air and the picturesque surroundings of the village of Koi-Tash. Beautiful views of the mountains, elegant architecture and magnificent interior create an atmosphere of wonderful rest.  Each window offers a breathtaking view of the majestic mountains and the colorful river of the Alamedin gorge.',
        "photos": [
          {"id": 10, "photo": "images/hotels/jannat_resort/hotelDoor.jpg"},
          {"id": 11, "photo": "images/hotels/jannat_resort/hotel0.jpg"},
          {"id": 12, "photo": "images/hotels/jannat_resort/hotel1.jpg"},
          {"id": 13, "photo": "images/hotels/jannat_resort/hotel2.jpg"},
          {"id": 14, "photo": "images/hotels/jannat_resort/hotel3.jpg"},
        ],
      },
    ],
  };

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

  void setFalseFavoriteIcon(int hotelId) {
    if (hotelId > -1) {
      for (int i = 0; i < _fetchedDataVisualisation.length; i++) {
        if (_fetchedDataVisualisation['results'][i]['id'] == hotelId) {
          _fetchedDataVisualisation['results'][i]['is_favorite'] = false;
        }
      }
    }
  }

  void setTrueFavoriteIcon(int hotelId) {
    if (hotelId > -1) {
      for (int i = 0; i < _fetchedDataVisualisation.length; i++) {
        if (_fetchedDataVisualisation['results'][i]['id'] == hotelId) {
          _fetchedDataVisualisation['results'][i]['is_favorite'] = true;
        }
      }
    }
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

    for (int i = 0; i < _fetchedDataVisualisation['results'].length; i++) {
      if ((_fetchedDataVisualisation['results'][i]['name'] as String)
          .toLowerCase()
          .contains(wordContains.toLowerCase())) {
        (searchedFetchedDataVisualisation['results'] as List)
            .add(_fetchedDataVisualisation['results'][i]);
      }
    }

    for (int i = 0; i < _fetchedDataVisualisation2['results'].length; i++) {
      if ((_fetchedDataVisualisation2['results'][i]['name'] as String)
          .toLowerCase()
          .contains(wordContains.toLowerCase())) {
        (searchedFetchedDataVisualisation['results'] as List)
            .add(_fetchedDataVisualisation2['results'][i]);
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

    for (int i = 0; i < _fetchedDataVisualisation['results'].length; i++) {
      if ((_fetchedDataVisualisation['results'][i]['is_favorite'] as bool) ==
          true) {
        (favoriteFetchedDataVisualisation['results'] as List)
            .add(_fetchedDataVisualisation['results'][i]);
      }
    }

    for (int i = 0; i < _fetchedDataVisualisation2['results'].length; i++) {
      if ((_fetchedDataVisualisation2['results'][i]['is_favorite'] as bool) ==
          true) {
        (favoriteFetchedDataVisualisation['results'] as List)
            .add(_fetchedDataVisualisation2['results'][i]);
      }
    }
    final String result = json.encode(favoriteFetchedDataVisualisation);
    return result;
  }
}
