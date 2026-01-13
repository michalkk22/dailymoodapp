import 'dart:async';

import 'package:class_pulse/data/models/session.dart';
import 'package:class_pulse/data/repositories/sessions_repository.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  StreamSubscription? _sub;
  final SessionsRepository _sessionsRepo;

  SessionsBloc(this._sessionsRepo) : super(SessionsStateUninitialized()) {
    on<SessionsEventInitialize>((event, emit) {
      _sub?.cancel();
      _sub = _sessionsRepo.sessions().listen(
        (sessions) => add(_SessionsEventLoad(sessions: sessions)),
      );
    });

    on<SessionsEventAdd>((event, emit) {
      _sessionsRepo.add(event.session);
    });

    on<SessionsEventDelete>((event, emit) {
      _sessionsRepo.delete(event.session);
    });

    on<_SessionsEventLoad>((event, emit) {
      emit(SessionStateLoaded(sessions: event.sessions));
    });
  }
}
