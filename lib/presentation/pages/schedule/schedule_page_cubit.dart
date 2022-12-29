import 'dart:developer';

import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/mappers/month_event_mapper.dart';
import 'package:sportly/domain/features/schedule/models/month_event.f.dart';
import 'package:sportly/domain/use_cases/get_month_events_use_case.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page_action.f.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page_state.f.dart';

@injectable
class SchedulePageCubit
    extends ActionCubit<SchedulePageState, SchedulePageAction> {
  SchedulePageCubit(
    this._eventMapper,
    this._getMonthEventsUseCase,
  ) : super(const SchedulePageState.loading());

  final MonthEventMapper _eventMapper;
  final GetMonthEventsUseCase _getMonthEventsUseCase;

  late int _teamId;

  void init(int teamId) async {
    _teamId = teamId;
    try {
      dispatch(const SchedulePageAction.showLoader());

      final events = await _getMonthEventsUseCase(_teamId, DateTime.now());
      dispatch(const SchedulePageAction.hideLoader());

      _emitIdle(events, DateTime.now());
    } catch (e) {
      log(e.toString());
      dispatch(const SchedulePageAction.hideLoader());
      emit(const SchedulePageState.error());
    }
  }

  void refreshEvents(DateTime date) async {
    try {
      dispatch(const SchedulePageAction.showLoader());
      final events = await _getMonthEventsUseCase(_teamId, date);
      dispatch(const SchedulePageAction.hideLoader());

      _emitIdle(events, date);
    } catch (e) {
      log(e.toString());
      dispatch(const SchedulePageAction.hideLoader());
      emit(const SchedulePageState.error());
    }
  }

  void _emitIdle(List<MonthEvent> events, DateTime initialMonth) {
    emit(
      SchedulePageState.idle(
        events: events
            .map(
              (event) => _eventMapper(event),
            )
            .toList(),
        initialMonth: initialMonth,
      ),
    );
  }
}
