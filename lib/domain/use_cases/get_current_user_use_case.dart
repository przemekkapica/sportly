import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentUserUseCase {
  GetCurrentUserUseCase(
    this._googleSignIn,
  );

  final GoogleSignIn _googleSignIn;

  GoogleSignInAccount? call() {
    return _googleSignIn.currentUser;
  }
}
