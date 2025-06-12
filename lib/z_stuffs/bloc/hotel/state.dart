part of 'bloc.dart';

sealed class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object> get props => [];
}

class HotelInitial extends HotelState {}

class HotelInitialLoading extends HotelState {
  final String message;
  const HotelInitialLoading({required this.message});

  @override
  List<Object> get props => [message];
}

class HotelInitialError extends HotelState {
  final String message;
  const HotelInitialError({required this.message});
  @override
  List<Object> get props => [message];
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

  @override
  List<Object> get props => [hotelsModel];
}
