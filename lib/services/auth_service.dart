import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthService {
  void initialize();
  Future<bool> logIn();
  Future<void> logOut();
  User? get user;
}
