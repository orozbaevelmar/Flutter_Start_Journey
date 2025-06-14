abstract class Attraction {
  // Destination, Attraction,

  //static Map<String, List<String>> mapInformation = {};

  Map<String, List<String>> get getMapInformation;

  /* void addToFavouriteElement1(String favouriteElement) {
    getMapInformation[favouriteElement]?[1] = 'f';
  } */
  void changeFavouriteIconToRed(String mapKey);

  void changeFavouriteIconToOutlined(String mapKey);

  String getDescription(String favouriteElementsName);

  String getPrice(String favouriteElementsName);

  String getRating(String favouriteElementsName);

  String getPictureOfFacade(String favouriteElementsName);

  String getPictures(String favouriteElementsName);

  String getLocation(String favouriteElementsName);

  dynamic getPostScreen(String mapkey);

  String showImageOnTap(String nameOfElement, int indexOfImage);
}
