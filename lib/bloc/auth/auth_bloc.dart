import 'package:class_pulse/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  User? get user => _authService.user;

  AuthBloc(this._authService) : super(AuthStateLoggedOut()) {
    on<AuthEventInitialize>((event, emit) async {
      await _authService.initialize();

      if (user != null) {
        emit(AuthStateLoggedIn(user: user!));
      } else {
        emit(AuthStateLoggedOut());
      }
    });

    on<AuthEventLogIn>((event, emit) async {
      try {
        await _authService.googleLogIn();
        emit(AuthStateLoggedIn(user: user!));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e: e));
      }
    });

    on<AuthEventLogOut>((event, emit) async {
      try {
        await _authService.logOut();
        emit(AuthStateLoggedIn(user: user!));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e: e));
      }
    });
  }
}
