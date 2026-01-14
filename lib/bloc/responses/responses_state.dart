part of 'responses_bloc.dart';

@immutable
abstract class ResponsesState {
  const ResponsesState();
}

class ResponsesStateNotInSession extends ResponsesState {
  const ResponsesStateNotInSession();
}

class ResponsesStateInSession extends ResponsesState {
  final Session session;
  final List<Response> responses;

  const ResponsesStateInSession({
    required this.session,
    required this.responses,
  });
}
