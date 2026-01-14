part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoggedOut extends AuthState {
  final Exception e;

  const AuthStateLoggedOut({required this.e});
}

class AuthStateLoggedIn extends AuthState {
  final User user;

  const AuthStateLoggedIn({required this.user});
}
