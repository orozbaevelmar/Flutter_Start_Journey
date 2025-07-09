part of 'bloc.dart';

sealed class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesInitialLoading extends FavoritesState {
  final String message;
  FavoritesInitialLoading({required this.message});
}

class FavoritesInitialError extends FavoritesState {
  final String message;
  FavoritesInitialError({required this.message});
}

class FavoritesEmpty extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final HotelListModel favoritesModel;
  final LoadingMore? loading;
  final LoadMoreError? error;
  FavoritesLoaded({
    required this.favoritesModel,
    this.loading,
    this.error,
  });
}
