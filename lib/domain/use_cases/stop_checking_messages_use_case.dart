import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/chat_repository.dart';

@injectable
class StopCheckingMessagesUseCase {
  StopCheckingMessagesUseCase(
    this._chatRepository,
  );

  final ChatRepository _chatRepository;

  void call() => _chatRepository.stopCheckingMessages();
}
