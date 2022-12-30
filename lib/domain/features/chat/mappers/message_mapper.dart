import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/models/message.f.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

@injectable
class MessageMapper extends DataMapper<Message, types.TextMessage> {
  MessageMapper();

  @override
  types.TextMessage call(Message data) {
    return types.TextMessage(
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
