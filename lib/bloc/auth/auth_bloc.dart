import 'package:class_pulse/data/models/user.dart';
import 'package:class_pulse/data/repositories/users_repository.dart';
import 'package:class_pulse/services/auth_service.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final UsersRepository _usersRepo;
  String? get userId => _authService.userId;
  User? user;

  AuthBloc(this._authService, this._usersRepo) : super(AuthStateLoggedOut()) {
    on<AuthEventInitialize>((event, emit) async {
      try {
        await _authService.initialize();
        await _tryToLogIn(emit);
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e: e));
      }
    });

    on<AuthEventLogIn>((event, emit) async {
      try {
        await _authService.logIn(event.email, event.password);
        await _tryToLogIn(emit);
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e: e));
      }
    });

    on<AuthEventRegister>((event, emit) async {
      try {
        await _authService.register(event.email, event.password);
        await _tryToLogIn(emit);
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e: e));
      }
    });

    on<AuthEventGoogleLogIn>((event, emit) async {
      try {
        await _authService.googleLogIn();
        await _tryToLogIn(emit);
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e: e));
      }
    });

    on<AuthEventLogOut>((event, emit) async {
      try {
        await _authService.logOut();
        emit(AuthStateLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e: e));
      }
    });
  }

  Future<void> _tryToLogIn(Emitter<AuthState> emit) async {
    if (userId != null) {
      user = await _usersRepo.get(userId!);
      if (user!.name == null || user!.role == null) {
        emit(AuthStateNeedUserData(user: User(userId: userId!)));
      } else {
        emit(AuthStateLoggedIn(user: User(userId: userId!)));
      }
    } else {
      emit(AuthStateLoggedOut());
    }
  }
}
