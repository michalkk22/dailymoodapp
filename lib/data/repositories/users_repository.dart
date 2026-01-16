import 'package:class_pulse/data/models/user.dart';

abstract interface class UsersRepository {
  Future<void> setName(User user, String name);
}
