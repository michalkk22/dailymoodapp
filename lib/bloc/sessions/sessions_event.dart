part of 'sessions_bloc.dart';

@immutable
abstract class SessionsEvent {
  const SessionsEvent();
}

class SessionsEventInitialize extends SessionsEvent {
  const SessionsEventInitialize();
}

class SessionsEventAdd extends SessionsEvent {
  final Session session;

  const SessionsEventAdd({required this.session});
}

class SessionsEventDelete extends SessionsEvent {
  final Session session;

  const SessionsEventDelete({required this.session});
}

class _SessionsEventLoad extends SessionsEvent {
  final List<Session> sessions;

  const _SessionsEventLoad({required this.sessions});
}
