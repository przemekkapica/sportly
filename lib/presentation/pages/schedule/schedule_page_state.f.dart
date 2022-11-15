import 'package:calendar_view/calendar_view.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_page_state.f.freezed.dart';

@freezed
class SchedulePageState with _$SchedulePageState {
  const factory SchedulePageState.loading() = SchedulePageStateLoading;

  const factory SchedulePageState.idle({
    required List<CalendarEventData> events,
  }) = SchedulePageStateIdle;

  const factory SchedulePageState.error() = SchedulePageStateError;
}
