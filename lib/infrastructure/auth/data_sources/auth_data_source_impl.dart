import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/infrastructure/auth/data_sources/auth_data_source.dart';

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  const AuthDataSourceImpl(
    this._googleSignIn,
    this._firebaseAuth,
  );

  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw (Exception('Sign in error'));
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();

    await _googleSignIn.signOut();
  }

  @override
  GoogleSignInAccount? getCurrentUser() {
    return _googleSignIn.currentUser;
  }

  @override
  Future<String?> getIdToken() async {
    return await _firebaseAuth.currentUser?.getIdToken();
  }
}
