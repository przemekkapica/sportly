import 'package:injectable/injectable.dart';
import 'package:sportly/domain/auth/auth_repository.dart';
import 'package:sportly/domain/auth/models/user.f.dart';

@injectable
class GetCurrentUserUseCase {
  GetCurrentUserUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  User? call() {
    return _authRepository.getCurrentUser();
  }
}
