import 'package:class_pulse/data/models/user.dart';
import 'package:class_pulse/data/repositories/users_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUsersRepository implements UsersRepository {
  final _users = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> setUserData(User user) async {
    try {
      await _users.doc(user.userId).set(user.toMap());
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<User> get(String id) async {
    try {
      final doc = await _users.doc(id).get();
      final data = doc.data();
      if (data == null) {
        throw Exception();
      }
      return User.fromMap(data, doc.id);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
