import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

part 'chat_page_state.f.freezed.dart';

@freezed
class ChatPageState with _$ChatPageState {
  const factory ChatPageState.loading() = ChatPageStateLoading;

  const factory ChatPageState.idle({
    required List<TextMessage> messages,
    required String userId,
  }) = ChatPageStateIdle;

  const factory ChatPageState.error() = ChatPageStateError;
}
