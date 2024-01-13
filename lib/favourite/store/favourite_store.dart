import 'dart:collection';
import 'package:start_journey/home_categories/hotel/store/hotel_store.dart';

class FavouriteStore {
  static final LinkedHashMap<String?, List> favouriteElementsInLinkedHashMap =
      LinkedHashMap();

  // favouriteMap == key: favourite element's name
  //               value: [0]=HotelStore   or    SightsStore
  //                      [1]=HotelPostScreen or SightsPostScreen

  // String: favourite element's name
  // List: [0] = HotelStore.mapHotelInformation or Sighstore.mapSightsInformation
  //       [1] = PostScreen     // category

  bool checkRedFavouriteIcon(Map mapInformation, String checkElement) {
    return mapInformation[checkElement]?[1].startsWith('f') ?? false;
  }

  /* Icon changeFavoureIconRedOrOutlined(String checkElement) {

    // It may need fixes //
    return (HotelStore.mapHotelInformation[checkElement]?[1].startsWith('u') ??
            false)
        ? Icon(
            Icons.favorite_outline_outlined,
            color: Colors.black,
          )
        : Icon(
            Icons.favorite,
            color: Colors.red,
          );

    /* HotelStore.mapHotelInformation.entries
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
          ); */
  } */

  void addToFavouriteElement(Map mapCategoryInformation,
      String favouriteElementKey, Object postScreen) {
    // change favourite signature in HashMap:-----------------------------------
    // It may need fixes
    mapCategoryInformation[favouriteElementKey]?[1] = 'f';
    /* (HotelStore.mapHotelInformation[favouriteElement]?[1].startsWith('u') ??
                false)
            ? 'f'
            : 'u'; */

    // add in LinkedHashMap elements(hotels, sights, places):-------------------
    favouriteElementsInLinkedHashMap[favouriteElementKey] = [
      mapCategoryInformation,
      postScreen
    ];
    //add(map, favouriteElement);
    /* favouriteElementsInLinkedHashMap
        .add(HotelStore.mapHotelInformation.entries.elementAt(index).key); */
  }

  // delete favourite element from LinkedHashMap:-------------------------------
  void deleteFromFavouriteElement(String elementsName) {
    HotelStore.mapInformation[elementsName]?[1] = 'u';
    /* (HotelStore.mapHotelInformation[elementsName]?[1].startsWith('f') ??
                false)
            ? 'u'
            : 'f'; */

    favouriteElementsInLinkedHashMap.remove(elementsName);
  }
}
