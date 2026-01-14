part of 'sessions_bloc.dart';

@immutable
abstract class SessionsState {
  final List<Session> sessions;
  const SessionsState({required this.sessions});
}

class SessionsStateUninitialized extends SessionsState {
  SessionsStateUninitialized() : super(sessions: []);
}

class SessionStateLoaded extends SessionsState {
  const SessionStateLoaded({required super.sessions});
}
