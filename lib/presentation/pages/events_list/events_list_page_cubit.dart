import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/delete_event_use_case.dart';
import 'package:sportly/domain/use_cases/get_day_events_use_case.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_action.f.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_state.f.dart';

@injectable
class EventsListPageCubit
    extends ActionCubit<EventsListPageState, EventsListPageAction> {
  EventsListPageCubit(
    this._getDayEventsUseCase,
    this._deleteEventUseCase,
  ) : super(const EventsListPageState.loading());

  final GetDayEventsUseCase _getDayEventsUseCase;
  final DeleteEventUseCase _deleteEventUseCase;

  late final int _teamId;

  Future<void> init(int teamId, DateTime date) async {
    _teamId = teamId;

    try {
      final events = await _getDayEventsUseCase(_teamId, date);

      emit(EventsListPageState.idle(events: events));
    } catch (e) {
      emit(const EventsListPageState.error());
    }
  }

  Future<void> deleteEvent(int eventId) async {
    try {
      await _deleteEventUseCase(_teamId, eventId);
    } catch (e) {
      emit(const EventsListPageState.error());
    }
  }
}
