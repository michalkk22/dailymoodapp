import 'dart:async';
import 'package:class_pulse/data/models/session.dart';
import 'package:class_pulse/data/repositories/sessions_repository.dart';

class MockSessionsRepo implements SessionsRepository {
  final _controller = StreamController<List<Session>>.broadcast();
  List<Session> _sessions = [];

  MockSessionsRepo() {
    // Seed demo data (looks like your design screenshot)
    _sessions = [
      Session(
        sessionId: 's1',
        subject: 'Math',
        teacher: 'Mrs. Carter',
        dateTime: DateTime.now()
            .add(const Duration(days: 1))
            .copyWith(hour: 10, minute: 0),
        isSubmitted: true,
      ),
      Session(
        sessionId: 's2',
        subject: 'History',
        teacher: 'Mr. Johnson',
        dateTime: DateTime.now()
            .add(const Duration(days: 3))
            .copyWith(hour: 13, minute: 30),
        isSubmitted: false,
      ),
      Session(
        sessionId: 's3',
        subject: 'Science',
        teacher: 'Mrs. Martinez',
        dateTime: DateTime.now()
            .add(const Duration(days: 5))
            .copyWith(hour: 9, minute: 0),
        isSubmitted: true,
      ),
    ];

    _addOnce();
  }

  Future<void> _addOnce() async {
    await Future.delayed(Duration(seconds: 15));
    _controller.add(_sessions);
  }

  @override
  Future<void> add(Session session) async {
    _sessions = [session, ..._sessions];
    _controller.add(_sessions);
  }

  @override
  Future<void> delete(Session session) async {
    _sessions = _sessions
        .where((s) => s.sessionId != session.sessionId)
        .toList();
    _controller.add(_sessions);
  }

  @override
  Stream<List<Session>> sessions() {
    print('sessions stream');
    return Stream.value([
      Session(
        dateTime: DateTime.now(),
        sessionId: '123',
        subject: 'sujbect',
        teacher: 'teacher name',
        isSubmitted: false,
      ),
    ]);
  }
}
