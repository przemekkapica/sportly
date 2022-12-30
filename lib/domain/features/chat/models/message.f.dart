import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.f.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String userId,
    required String text,
    required String firstName,
    required String? lastName,
    required DateTime createdAt,
  }) = _Message;
}
