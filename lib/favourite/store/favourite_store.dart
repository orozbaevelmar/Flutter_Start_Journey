import 'dart:collection';
import 'package:start_journey/home_categories/store_abstract_class/attraction.dart';

class FavouriteStore {
  static final LinkedHashMap<String?, Attraction>
      favouriteElementsInLinkedHashMap = LinkedHashMap();

  // favouriteMap == key: favourite element's name
  //               value: HotelStore()   or    SightsStore()

  bool checkRedFavouriteIcon(String checkElement) {
    return favouriteElementsInLinkedHashMap[checkElement]
            ?.getMapInformation[checkElement]?[1]
            .startsWith('f') ??
        false;
    /* mapInformation[checkElement]?[1].startsWith('f') ?? false; */
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

  void addToFavouriteElement(
      String favouriteElementKey, Attraction attraction) {
    // change favourite signature in HashMap:-----------------------------------
    // It may need fixes
    attraction.changeFavouriteIconToRed(favouriteElementKey);

    // favouriteMap == key: favourite element's name
    //               value: [0]=HotelStore   or    SightsStore
    //                      [1]=HotelPostScreen or SightsPostScreen

    /* favouriteElementsInLinkedHashMap[favouriteElementKey]
        ?.getMapInformation[favouriteElementKey]?[1] = 'f'; */

    /* mapCategoryInformation[favouriteElementKey]?[1] = 'f'; */

    /* (HotelStore.mapHotelInformation[favouriteElement]?[1].startsWith('u') ??
                false)
            ? 'f'
            : 'u'; */

    // add in LinkedHashMap elements(hotels, sights, places):-------------------
    favouriteElementsInLinkedHashMap[favouriteElementKey] = attraction;
    //add(map, favouriteElement);
    /* favouriteElementsInLinkedHashMap
        .add(HotelStore.mapHotelInformation.entries.elementAt(index).key); */
  }

  // delete favourite element from LinkedHashMap:-------------------------------
  void deleteFromFavouriteElement(String elementsName) {
    favouriteElementsInLinkedHashMap[elementsName]
        ?.changeFavouriteIconToOutlined(elementsName);
    /* favouriteElementsInLinkedHashMap[elementsName]
        ?.getMapInformation[elementsName]?[1] = 'u'; */
    /* (HotelStore.mapHotelInformation[elementsName]?[1].startsWith('f') ??
                false)
            ? 'u'
            : 'f'; */

    favouriteElementsInLinkedHashMap.remove(elementsName);
  }
}
