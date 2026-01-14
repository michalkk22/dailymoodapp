import 'dart:async';

import 'package:class_pulse/data/models/response.dart';
import 'package:class_pulse/data/models/session.dart';
import 'package:class_pulse/data/repositories/responses_repository.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'responses_event.dart';
part 'responses_state.dart';

class ResponsesBloc extends Bloc<ResponsesEvent, ResponsesState> {
  final ResponsesRepository _responsesRepo;
  StreamSubscription? _sub;
  Session? session;
  List<Response> responses = [];

  ResponsesBloc(this._responsesRepo) : super(ResponsesStateNotInSession()) {
    on<ResponsesEventSelectedSession>((event, emit) {
      session = event.session;
      _sub = _responsesRepo.responses(session!.sessionId).listen((sessions) {
        add(_ResponsesEventLoad(responses: sessions));
      });
      emit(ResponsesStateInSession(session: session!, responses: responses));
    });

    on<ResponsesEventLeftSession>((event, emit) {
      _sub?.cancel();
      session = null;
      emit(ResponsesStateNotInSession());
    });

    on<ResponsesEventAction>((event, emit) {
      switch (event.action) {
        case ResponseAction.add:
          _responsesRepo.add(session!.sessionId, event.response);
          break;
        case ResponseAction.update:
          _responsesRepo.update(session!.sessionId, event.response);
          break;
        case ResponseAction.delete:
          _responsesRepo.delete(session!.sessionId, event.response);
          break;
      }
    });

    on<_ResponsesEventLoad>((event, emit) {
      responses = event.responses;
      emit(ResponsesStateInSession(session: session!, responses: responses));
    });
  }
}
