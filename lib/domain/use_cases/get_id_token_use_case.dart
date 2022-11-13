import 'package:injectable/injectable.dart';
import 'package:sportly/domain/auth/auth_repository.dart';

@injectable
class GetIdTokenUseCase {
  GetIdTokenUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<String> call() async {
    return await _authRepository.getIdToken();
  }
}
