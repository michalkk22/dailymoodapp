import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthService {
  Future<void> initialize();
  Future<void> googleLogIn();
  Future<void> logIn(String email, String password);
  Future<void> logOut();
  User? get user;
}
