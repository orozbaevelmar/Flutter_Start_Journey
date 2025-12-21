part of 'hotel_bloc.dart';

sealed class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object?> get props => [];
}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {
  final String message;
  const HotelLoading({required this.message});

  @override
  List<Object?> get props => [message];
}

class HotelInitialError extends HotelState {
  final String message;
  const HotelInitialError({required this.message});
  @override
  List<Object?> get props => [message];
}

class HotelEmpty extends HotelState {
  final String message;

  const HotelEmpty({required this.message});
  @override
  List<Object?> get props => [message];
}

class HotelLoaded extends HotelState {
  final HotelListEntity hotelistModel;
  final LoadingMore? loadingMore;

  const HotelLoaded({
    required this.hotelistModel,
    this.loadingMore,
  });

  @override
  List<Object?> get props => [hotelistModel, loadingMore];
}
