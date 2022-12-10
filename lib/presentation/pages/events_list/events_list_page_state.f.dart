import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/schedule/models/event.f.dart';

part 'events_list_page_state.f.freezed.dart';

@freezed
class EventsListPageState with _$EventsListPageState {
  const factory EventsListPageState.loading() = EventsListPageStateLoading;

  const factory EventsListPageState.idle({
    required List<Event> events,
  }) = EventsListPageStateIdle;

  const factory EventsListPageState.error() = EventsListPageStateError;
}
