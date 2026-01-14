part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventLogIn extends AuthEvent {
  const AuthEventLogIn();
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
