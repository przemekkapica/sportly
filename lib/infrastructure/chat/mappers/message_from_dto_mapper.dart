import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/models/message.f.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/infrastructure/chat/dtos/message_dto.dart';

@injectable
class MessageFromDtoMapper extends DataMapper<MessageDto, Message> {
  MessageFromDtoMapper();

  @override
  Message call(MessageDto data) {
    return Message(
      id: data.messageId.toString(),
      userId: data.userId.toString(),
      createdAt: DateTime.parse(data.messageTime),
      firstName: data.firstName,
      lastName: data.lastName,
      text: data.message,
    );
  }
}
