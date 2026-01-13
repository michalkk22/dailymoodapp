import 'package:class_pulse/data/models/session.dart';

abstract interface class SessionsRepository {
  Stream<List<Session>> sessions();
  Future<void> add(Session session);
  Future<void> delete(Session session);
}
