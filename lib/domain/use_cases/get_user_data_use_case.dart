import 'package:injectable/injectable.dart';
import 'package:sportly/domain/auth/models/internal_user.f.dart';
import 'package:sportly/domain/features/chat/chat_repository.dart';

@injectable
class GetUserDataUseCase {
  GetUserDataUseCase(
    this._chatRepository,
  );

  final ChatRepository _chatRepository;

  Future<InternalUser> call() async {
    return await _chatRepository.getUserData();
  }
}
