import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/chat_repository.dart';

@injectable
class StartCheckingMessagesUseCase {
  StartCheckingMessagesUseCase(
    this._chatRepository,
  );

  final ChatRepository _chatRepository;

  void call(int teamId) =>
      _chatRepository.startCheckingMessages(teamId, const Duration(seconds: 1));
}
