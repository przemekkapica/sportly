import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_page_state.f.freezed.dart';

@freezed
class SchedulePageState with _$SchedulePageState {
  const factory SchedulePageState.loading() = SchedulePageStateLoading;

  const factory SchedulePageState.idle() = SchedulePageStateIdle;

  const factory SchedulePageState.error() = SchedulePageStateError;
}
