import 'package:class_pulse/data/models/user.dart';

abstract interface class UsersRepository {
  Future<User> get(String id);
  Future<void> setUserData(User user);
}
