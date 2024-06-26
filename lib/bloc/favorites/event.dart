part of 'bloc.dart';

sealed class FavoritesEvent {}

class FavoritesLoadEvent extends FavoritesEvent {}

class FavoriteDrugRemoveEvent extends FavoritesEvent {
  final Result results;
  FavoriteDrugRemoveEvent(this.results);
}
