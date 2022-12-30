import 'package:json_annotation/json_annotation.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto {
  MessageDto({
    required this.messageId,
    required this.userId,
    required this.message,
    required this.firstName,
    required this.lastName,
    required this.messageTime,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);

  final int messageId;
  final int userId;
  final String message;
  final String firstName;
  final String lastName;
  final String messageTime;
}
