import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/chat_repository.dart';
import 'package:sportly/domain/features/chat/models/message.f.dart';

@injectable
class GetMessagesStreamUseCase {
  GetMessagesStreamUseCase(
    this._chatRepository,
  );

  final ChatRepository _chatRepository;

  Stream<List<Message>> call() => _chatRepository.messagesStream;
}
