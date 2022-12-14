import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_event_page_state.f.freezed.dart';

@freezed
class EditEventPageState with _$EditEventPageState {
  const factory EditEventPageState.loading() = EditEventPageStateLoading;

  const factory EditEventPageState.idle({
    required DateTime selectedDate,
    required bool submitButtonEnabled,
  }) = EditEventPageStateIdle;

  const factory EditEventPageState.error() = EditEventPageStateError;
}
