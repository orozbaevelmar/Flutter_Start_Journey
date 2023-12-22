import 'dart:collection';
import 'package:start_journey/home_categories/hotel/store/hotel_store.dart';

class FavouriteStore {
  static final LinkedHashSet<String?> favouriteElementsInLinkedHashSet =
      LinkedHashSet();

  bool checkRedFavouriteIcon(String checkElement) {
    return HotelStore.mapHotelInformation[checkElement]?[1].startsWith('f') ??
        false;
  }

  /* Icon changeFavoureIconRedOrOutlined(String checkElement) {

    // It may need fixes
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

  void addToFavouriteElement(String favouriteElement) {
    // change favourite signature in HashMap:-----------------------------------
    // It may need fixes
    HotelStore.mapHotelInformation[favouriteElement]?[1] = 'f';
    /* (HotelStore.mapHotelInformation[favouriteElement]?[1].startsWith('u') ??
                false)
            ? 'f'
            : 'u'; */

    // add in LinkedHashMap elements(hotels, sights, places):-------------------
    favouriteElementsInLinkedHashSet.add(favouriteElement);
    /* favouriteElementsInLinkedHashSet
        .add(HotelStore.mapHotelInformation.entries.elementAt(index).key); */
  }

  // delete favourite element from LinkedHashMap:-------------------------------
  void deleteFromFavouriteElement(String elementsName) {
    HotelStore.mapHotelInformation[elementsName]?[1] = 'u';
    /* (HotelStore.mapHotelInformation[elementsName]?[1].startsWith('f') ??
                false)
            ? 'u'
            : 'f'; */

    favouriteElementsInLinkedHashSet.remove(elementsName);
  }
}
