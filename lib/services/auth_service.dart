import 'package:class_pulse/data/models/user.dart';

abstract interface class AuthService {
  Future<void> initialize();
  Future<void> googleLogIn();
  Future<void> logIn(String email, String password);
  Future<void> logOut();
  User? get user;
}
