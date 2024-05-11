part of 'bloc.dart';

sealed class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object> get props => [];
}

class ProductsLoadEvent extends HotelEvent {}
