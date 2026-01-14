part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogIn extends AuthEvent {
  const AuthEventLogIn();
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
