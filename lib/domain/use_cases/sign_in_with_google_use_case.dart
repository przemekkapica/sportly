import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInWithGoogleUseCase {
  SignInWithGoogleUseCase(
    this._googleSignIn,
  );

  final GoogleSignIn _googleSignIn;

  Future<void> call() async {
    await _googleSignIn.signIn();
  }
}
