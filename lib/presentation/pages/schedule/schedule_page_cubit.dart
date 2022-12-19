import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/mappers/month_event_mapper.dart';
import 'package:sportly/domain/features/schedule/models/month_event.f.dart';
import 'package:sportly/domain/use_cases/get_month_events_use_case.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page_state.f.dart';

@injectable
class SchedulePageCubit extends Cubit<SchedulePageState> {
  SchedulePageCubit(
    this._eventMapper,
    this._getMonthEventsUseCase,
  ) : super(const SchedulePageState.loading());

  final MonthEventMapper _eventMapper;
  final GetMonthEventsUseCase _getMonthEventsUseCase;

  late final int _teamId;

  void init(int teamId) async {
    _teamId = teamId;

    final events = await _getMonthEventsUseCase(_teamId, DateTime.now());

    _emitIdle(events);
  }

  void refreshEvents(DateTime date) async {
    final events = await _getMonthEventsUseCase(_teamId, DateTime.now());
    _emitIdle(events);
  }

  void _emitIdle(List<MonthEvent> events) {
    emit(
      SchedulePageState.idle(
        events: events
            .map(
              (event) => _eventMapper(event),
            )
            .toList(),
      ),
    );
  }
}
