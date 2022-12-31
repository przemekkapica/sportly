import 'package:sportly/domain/auth/models/user.f.dart';

abstract class AuthRepository {
  Future<void> signInWithGoogle();

  Future<void> signOut();

  User? getCurrentUser();

  Future<String?> getIdToken();
}
