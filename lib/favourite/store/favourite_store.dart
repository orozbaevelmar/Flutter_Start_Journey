import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:start_journey/home_categories/hotel/store/hotel_store.dart';

class FavouriteStore {
  static final LinkedHashSet<String?> favouriteElementsInLinkedHashSet =
      LinkedHashSet();

  Icon checkFavoureIconRedOrOutlined(int index) {
    /*  // update value to 'f' and 'u'
    HotelStore.mapHotelInformation.entries
            .elementAt(index)
            .value
            .elementAt(1)
            .startsWith('u') ? HotelStore.mapHotelInformation.update(key, (value) => 'f') */

    return HotelStore.mapHotelInformation.entries
            .elementAt(index)
            .value
            .elementAt(1)
            .startsWith('u')
        ? Icon(
            Icons.favorite_outline_outlined,
            color: Colors.black,
          )
        : Icon(
            Icons.favorite,
            color: Colors.red,
          );
  }

  void addToFavouriteElement(int index) {
    // change favourite signature in HashMap:-----------------------------------
    HotelStore.mapHotelInformation.entries.elementAt(index).value[1] =
        HotelStore.mapHotelInformation.entries
                .elementAt(index)
                .value
                .elementAt(1)
                .startsWith('u')
            ? 'f'
            : 'u';

    // add in LinkedHashMap elements(hotels, sights, places):-------------------
    favouriteElementsInLinkedHashSet
        .add(HotelStore.mapHotelInformation.entries.elementAt(index).key);
  }

  // delete favourite element from LinkedHashMap:-------------------------------
  void deleteFromFavouriteElement(String elementsName) {
    favouriteElementsInLinkedHashSet.remove(elementsName);
  }
}
