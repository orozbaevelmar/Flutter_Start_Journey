import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/cleanArch/features/auth/domain/usecases/sign_in_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _userSignUp;
  AuthBloc({required SignInUseCase userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (l) => emit(AuthFailure(l?.message ?? 'Erorr')),
      (r) => emit(AuthSuccess()),
    );
  }
}
