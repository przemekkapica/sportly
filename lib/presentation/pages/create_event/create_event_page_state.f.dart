import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_event_page_state.f.freezed.dart';

@freezed
class CreateEventPageState with _$CreateEventPageState {
  const factory CreateEventPageState.loading() = CreateEventPageStateLoading;

  const factory CreateEventPageState.idle({
    required DateTime selectedDate,
    required bool submitButtonEnabled,
  }) = CreateEventPageStateIdle;

  const factory CreateEventPageState.error() = CreateEventPageStateError;
}
