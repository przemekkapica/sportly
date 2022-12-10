import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/get_day_events_use_case.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_action.f.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_state.f.dart';

@injectable
class EventsListPageCubit
    extends ActionCubit<EventsListPageState, EventsListPageAction> {
  EventsListPageCubit(
    this._getDayEventsUseCase,
  ) : super(const EventsListPageState.loading());

  final GetDayEventsUseCase _getDayEventsUseCase;

  Future<void> init(int teamId, DateTime date) async {
    try {
      final events = await _getDayEventsUseCase(teamId, date);

      emit(EventsListPageState.idle(events: events));
    } catch (e) {
      emit(const EventsListPageState.error());
    }
  }
}
