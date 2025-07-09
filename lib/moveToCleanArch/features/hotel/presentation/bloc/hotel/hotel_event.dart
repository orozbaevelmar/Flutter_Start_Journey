// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hotel_bloc.dart';

sealed class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object> get props => [];
}

class HotelLoadEvent extends HotelEvent {
  //final String url = '${MString.BASE_URL}/hotels/';
  final String url = HowLooksFetchedDataHotel.fetchedResponseBodyVisualisation;
  final bool isInitial;
  HotelLoadEvent({
    required this.isInitial,
  });

  @override
  List<Object> get props => [url, isInitial];
}

class HotelAfterClearingSearchField extends HotelEvent {
  @override
  List<Object> get props => [];
}

class HotelSearchEvent extends HotelEvent {
  final String url;
  final bool isInitial;
  final String hotelsNameContains;

  HotelSearchEvent({
    required this.isInitial,
    required this.hotelsNameContains,
  }) : url = HowLooksFetchedDataHotel.searchCompleted(hotelsNameContains);
  //"${MString.BASE_URL}/hotels/?search=$hotelsNameContains";
}
