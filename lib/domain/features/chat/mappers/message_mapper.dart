import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/models/message.f.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

typedef ChatMessage = types.TextMessage;

@injectable
class MessageMapper extends DataMapper<Message, ChatMessage> {
  MessageMapper();

  @override
  ChatMessage call(Message data) {
    return ChatMessage(
      createdAt: data.createdAt.millisecond,
      id: data.id,
      text: data.text,
      author: types.User(
        id: '1',
        firstName: data.firstName,
        lastName: data.lastName,
      ),
      type: types.MessageType.text,
      // status: 'seen',
    );
  }
}
