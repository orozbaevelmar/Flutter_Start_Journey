import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/moveToCleanArch/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess(r)),
    );
  }
}
