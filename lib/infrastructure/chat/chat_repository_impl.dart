import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/auth/models/internal_user.f.dart';
import 'package:sportly/domain/features/chat/chat_repository.dart';
import 'package:sportly/domain/features/chat/models/message.f.dart';
import 'package:sportly/infrastructure/auth/data_sources/user_data_source.dart';
import 'package:sportly/infrastructure/auth/mappers/internal_user_from_dto_mapper.dart';
import 'package:sportly/infrastructure/chat/data_sources/chat_data_source.dart';
import 'package:sportly/infrastructure/chat/mappers/message_from_dto_mapper.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(
    this._chatDataSource,
    this._messageFromDtoMapper,
    this._userDataSource,
    this._internalUserFromDtoMapper,
  );

  final ChatDataSource _chatDataSource;
  final MessageFromDtoMapper _messageFromDtoMapper;
  final UserDataSource _userDataSource;
  final InternalUserFromDtoMapper _internalUserFromDtoMapper;

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

  @override
  Future<InternalUser> getUserData() async {
    final dto = await _userDataSource.getUserData();

    return _internalUserFromDtoMapper(dto);
  }
}
