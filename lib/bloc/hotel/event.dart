part of 'bloc.dart';

sealed class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object> get props => [];
}

class HotelLoadEvent extends HotelEvent {}

class HotelSearchEvent extends HotelEvent {
  final String hotelsNameContains;
  final bool isInitial;

  const HotelSearchEvent({
    required this.hotelsNameContains,
    required this.isInitial,
  });
}
