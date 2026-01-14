part of 'responses_bloc.dart';

@immutable
abstract class ResponsesEvent {
  const ResponsesEvent();
}

class ResponsesEventSelectedSession extends ResponsesEvent {
  final Session session;

  const ResponsesEventSelectedSession({required this.session});
}

class ResponsesEventLeftSession extends ResponsesEvent {
  const ResponsesEventLeftSession();
}

class ResponsesEventAction extends ResponsesEvent {
  final ResponseAction action;
  final Response response;

  const ResponsesEventAction({required this.action, required this.response});
}

class _ResponsesEventLoad extends ResponsesEvent {
  final List<Response> responses;

  const _ResponsesEventLoad({required this.responses});
}

enum ResponseAction { add, update, delete }
