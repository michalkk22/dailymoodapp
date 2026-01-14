import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthService {
  Future<void> initialize();
  Future<void> logIn();
  Future<void> logOut();
  User? get user;
}
