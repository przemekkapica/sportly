import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/chat_repository.dart';
import 'package:sportly/domain/features/chat/mappers/message_mapper.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

@injectable
class GetMessagesUseCase {
  GetMessagesUseCase(
    this._chatRepository,
    this._messageMapper,
  );

  final ChatRepository _chatRepository;
  final MessageMapper _messageMapper;

  Future<List<TextMessage>> call(int teamId) async {
    final messages = await _chatRepository.getMessages(teamId);

    return messages.map((message) => _messageMapper(message)).toList();
  }
}
