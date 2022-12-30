import 'package:json_annotation/json_annotation.dart';
import 'package:sportly/infrastructure/chat/dtos/message_dto.dart';

part 'get_messages_dto.g.dart';

@JsonSerializable()
class GetMessagesDto {
  GetMessagesDto({
    required this.messages,
  });

  factory GetMessagesDto.fromJson(Map<String, dynamic> json) =>
      _$GetMessagesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetMessagesDtoToJson(this);

  final List<MessageDto> messages;
}
