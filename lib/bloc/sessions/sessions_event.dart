part of 'sessions_bloc.dart';

@immutable
abstract class SessionsEvent {
  const SessionsEvent();
}

class _SessionsEventUpdated {
  final List<Session> sessions;

  const _SessionsEventUpdated({required this.sessions});
}
