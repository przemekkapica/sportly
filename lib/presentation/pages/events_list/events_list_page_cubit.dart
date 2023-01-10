import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/day_event.f.dart';
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
  late final DateTime _date;

  Future<void> init(int teamId, DateTime date) async {
    _teamId = teamId;
    _date = date;

    try {
      final events = await _getDayEventsUseCase(_teamId, _date);

      _emitIdle(events);
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
      emit(const EventsListPageState.error());
    }
  }

  Future<void> refreshEvents() async {
    try {
      final events = await _getDayEventsUseCase(_teamId, _date);

      _emitIdle(events);
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
      emit(const EventsListPageState.error());
    }
  }

  Future<void> deleteEvent(int eventId) async {
    try {
      dispatch(const EventsListPageAction.showLoader());
      await _deleteEventUseCase(_teamId, eventId);

      final events = await _getDayEventsUseCase(_teamId, _date);
      if (events.isEmpty) {
        dispatch(const EventsListPageAction.deleteSuccess(popPage: true));
      } else {
        dispatch(const EventsListPageAction.deleteSuccess(popPage: false));
        _emitIdle(events);
      }
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
      emit(const EventsListPageState.error());
    }
    dispatch(const EventsListPageAction.hideLoader());
  }

  void _emitIdle(List<DayEvent> events) {
    if (events.isEmpty) {
      emit(EventsListPageState.noEvents(date: _date));
    } else {
      emit(EventsListPageState.idle(events: events, date: _date));
    }
  }
}
