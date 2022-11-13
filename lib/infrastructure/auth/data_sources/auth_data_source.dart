import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDataSource {
  Future<void> signInWithGoogle();

  Future<void> signOut();

  GoogleSignInAccount? getCurrentUser();

  Future<String?> getIdToken();
}
