part of 'bloc.dart';

sealed class SightsEvent extends Equatable {
  const SightsEvent();

  @override
  List<Object> get props => [];
}

class SightsLoadEvent extends SightsEvent {}

class SightsSearchEvent extends SightsEvent {
  final String sightsNameContains;
  final bool isInitial;

  const SightsSearchEvent({
    required this.sightsNameContains,
    required this.isInitial,
  });
}
