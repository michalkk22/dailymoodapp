import '../models/response.dart';

abstract interface class ResponsesRepository {
  Stream<List<Response>> responses(String sessionId);

  Future<void> add(String sessionId, Response response);

  Future<void> update(String sessionId, Response response);

  Future<void> delete(String sessionId, Response response);
}
