part of 'bloc.dart';

sealed class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object> get props => [];
}

class HotelInitial extends HotelState {}

//State for initial Loading when current page will be 1
class HotelInitialLoading extends HotelState {
  final String message;
  const HotelInitialLoading({required this.message});
}

class HotelInitialError extends HotelState {
  final String message;
  const HotelInitialError({required this.message});
}

class HotelEmpty extends HotelState {}

class HotelLoaded extends HotelState {
  final HotelsModel hotelsModel;
  final LoadingMore? loading;
  final LoadMoreError? error;
  HotelLoaded({
    required this.hotelsModel,
    this.loading,
    this.error,
  });
}
