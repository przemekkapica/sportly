import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_event_page_state.f.freezed.dart';

@freezed
class UpdateEventPageState with _$UpdateEventPageState {
  const factory UpdateEventPageState.loading() = UpdateEventPageStateLoading;

  const factory UpdateEventPageState.idle({
    required DateTime selectedDate,
    required bool submitButtonEnabled,
  }) = UpdateEventPageStateIdle;

  const factory UpdateEventPageState.error() = UpdateEventPageStateError;
}
