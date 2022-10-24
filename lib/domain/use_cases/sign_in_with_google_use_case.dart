import 'package:injectable/injectable.dart';
import 'package:sportly/domain/auth/auth_repository.dart';

@injectable
class SignInWithGoogleUseCase {
  SignInWithGoogleUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  Future<void> call() async {
    await _authRepository.signInWithGoogle();
  }
}
