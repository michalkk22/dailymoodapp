abstract interface class AuthService {
  Future<void> initialize();
  Future<void> googleLogIn();
  Future<void> logIn(String email, String password);
  Future<void> logOut();
  Future<void> register(String email, String password);
  String? get userId;
}
