import 'package:class_pulse/data/models/session.dart';
import 'package:class_pulse/data/repositories/sessions_repository.dart';

class MockSessionsRepo implements SessionsRepository {
  @override
  Future<void> add(Session session) async {
    print('add session');
  }

  @override
  Future<void> delete(Session session) async {
    print('delete session');
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
