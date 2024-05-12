class HowLooksFetchedData {
  final howLooksJsonFormatData = {
    "count": 10,
    "next": "<MString.BASE_URL>/hotels/?page=2",
    "previous": null,
    "results": [
      {
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
  static final fetchedResponseBody = _fetchedDataVisualisation.toString();
  static final _fetchedDataVisualisation = {
    "count": 2,
    "next": "<MString.BASE_URL>/hotels/?page=2",
    "previous": null,
    "results": [
      {
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
        "name": 'Jannat Resort',
        "location": 'Osh, Kyrgyzstan',
        "is_favorite": true,
        "rating": 5,
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
}
