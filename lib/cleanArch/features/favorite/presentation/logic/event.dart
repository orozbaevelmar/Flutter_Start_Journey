part of 'bloc.dart';

sealed class FavoritesEvent {}

class FavoritesLoadEvent extends FavoritesEvent {}

class FavoriteDrugRemoveEvent extends FavoritesEvent {
  final HotelModel results;
  FavoriteDrugRemoveEvent(this.results);
}
