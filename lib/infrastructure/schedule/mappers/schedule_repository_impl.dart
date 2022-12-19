import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/create_event.f.dart';
import 'package:sportly/domain/features/schedule/models/month_event.f.dart';
import 'package:sportly/domain/features/schedule/models/update_event.f.dart';
import 'package:sportly/domain/features/schedule/models/day_event.f.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';
import 'package:sportly/infrastructure/schedule/data_sources/schedule_data_source.dart';
import 'package:sportly/infrastructure/schedule/mappers/create_event_mapper.dart';
import 'package:sportly/infrastructure/schedule/mappers/day_event_mapper.dart';
import 'package:sportly/infrastructure/schedule/mappers/month_event_mapper.dart';

@LazySingleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl(
    this._scheduleDataSource,
    this._createEventMapper,
    this._dayEventMapper,
    this._monthEventMapper,
  );

  final ScheduleDataSource _scheduleDataSource;
  final CreateEventMapper _createEventMapper;
  final DayEventMapper _dayEventMapper;
  final MonthEventMapper _monthEventMapper;

  @override
  Future<void> createEvent(int teamId, CreateEvent createEvent) async {
    return await _scheduleDataSource.createEvent(
      teamId,
      _createEventMapper(createEvent),
    );
  }

  @override
  Future<List<MonthEvent>> getMonthEvents(int teamId, DateTime date) async {
    final dto = await _scheduleDataSource.getMonthEvents(
      teamId,
      date.toIso8601String(),
    );
    final result = dto.events.map((event) => _monthEventMapper(event)).toList();

    return result;
  }

  @override
  Future<List<DayEvent>> getDayEvents(int teamId, DateTime date) async {
    final dto = await _scheduleDataSource.getDayEvents(
      teamId,
      date.toIso8601String(),
    );
    final result = dto.events.map((event) => _dayEventMapper(event)).toList();

    return result;
  }

  @override
  Future<void> updateEvent(int teamId, UpdateEvent editEvent) async {
    return;
  }

  @override
  Future<void> deleteEvent(int teamId, int eventId) async {
    return;
  }
}
