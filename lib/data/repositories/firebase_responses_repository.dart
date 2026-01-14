import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';
import 'responses_repository.dart';

class FirebaseResponsesRepository implements ResponsesRepository {
  final FirebaseFirestore _firestore;

  FirebaseResponsesRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Response>> responses(String sessionId) {
    return _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('responses')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Response.fromMap(doc.data());
      }).toList();
    });
  }

  @override
  Future<void> add(String sessionId, Response response) async {
    await _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('responses')
        .doc(response.studentId)
        .set(response.toMap());
  }

  @override
  Future<void> update(String sessionId, Response response) async {
    await _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('responses')
        .doc(response.studentId)
        .update(response.toMap());
  }

  @override
  Future<void> delete(String sessionId, Response response) async {
    await _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('responses')
        .doc(response.studentId)
        .delete();
  }
}