import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/schedule/models/day_event.f.dart';

part 'events_list_page_state.f.freezed.dart';

@freezed
class EventsListPageState with _$EventsListPageState {
  const factory EventsListPageState.loading() = EventsListPageStateLoading;

  const factory EventsListPageState.idle({
    required List<DayEvent> events,
  }) = EventsListPageStateIdle;

  const factory EventsListPageState.error() = EventsListPageStateError;
}
