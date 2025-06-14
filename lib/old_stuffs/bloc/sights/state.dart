part of 'bloc.dart';

sealed class SightsState extends Equatable {
  const SightsState();

  @override
  List<Object> get props => [];
}

class SightsInitial extends SightsState {}

class SightsInitialLoading extends SightsState {
  final String message;
  const SightsInitialLoading({required this.message});

  @override
  List<Object> get props => [message];
}

class SightsInitialError extends SightsState {
  final String message;
  const SightsInitialError({required this.message});
  @override
  List<Object> get props => [message];
}

class SightsEmpty extends SightsState {}

class SightsLoaded extends SightsState {
  final SightsModel sightsModel;
  final LoadingMore? loading;
  final LoadMoreError? error;
  SightsLoaded({
    required this.sightsModel,
    this.loading,
    this.error,
  });

  @override
  List<Object> get props => [sightsModel];
}
