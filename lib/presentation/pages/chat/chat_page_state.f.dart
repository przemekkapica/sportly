import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_page_state.f.freezed.dart';

@freezed
class ChatPageState with _$ChatPageState {
  const factory ChatPageState.loading() = ChatPageStateLoading;

  const factory ChatPageState.idle() = ChatPageStateIdle;

  const factory ChatPageState.error() = ChatPageStateError;
}
