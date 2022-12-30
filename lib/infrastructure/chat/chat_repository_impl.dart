import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/chat_repository.dart';
import 'package:sportly/domain/features/chat/models/message.f.dart';
import 'package:sportly/infrastructure/chat/data_sources/chat_data_source.dart';
import 'package:sportly/infrastructure/chat/mappers/message_from_dto_mapper.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(
    this._chatDataSource,
    this._messageFromDtoMapper,
  );

  final ChatDataSource _chatDataSource;
  final MessageFromDtoMapper _messageFromDtoMapper;

  @override
  Future<List<Message>> getMessages(int teamId) async {
    final dto = await this._chatDataSource.getMessages(teamId);

    return dto.messages
        .map((message) => _messageFromDtoMapper(message))
        .toList();
  }

  @override
  Future<void> sendMessage(int teamId, String message) async {
    return await _chatDataSource.sendMessage(teamId, message);
  }
}
