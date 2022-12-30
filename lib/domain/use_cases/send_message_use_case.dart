import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/chat_repository.dart';

@injectable
class SendMessageUseCase {
  SendMessageUseCase(
    this._chatRepository,
  );

  final ChatRepository _chatRepository;

  Future<void> call(int teamId, String message) async {
    return await _chatRepository.sendMessage(teamId, message);
  }
}
