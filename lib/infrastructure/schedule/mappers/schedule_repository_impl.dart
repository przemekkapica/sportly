import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/create_event.f.dart';
import 'package:sportly/domain/features/schedule/models/month_event.f.dart';
import 'package:sportly/domain/features/schedule/models/update_event.f.dart';
import 'package:sportly/domain/features/schedule/models/day_event.f.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';
import 'package:sportly/infrastructure/schedule/data_sources/schedule_data_source.dart';
import 'package:sportly/infrastructure/schedule/mappers/create_event_mapper.dart';

@LazySingleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl(
    this._scheduleDataSource,
    this._createEventMapper,
  );

  final ScheduleDataSource _scheduleDataSource;
  final CreateEventMapper _createEventMapper;

  @override
  Future<void> createEvent(int teamId, CreateEvent createEvent) async {
    return await _scheduleDataSource.createEvent(
      teamId,
      _createEventMapper(createEvent),
    );
  }

  @override
  Future<List<MonthEvent>> getMonthEvents(int teamId, DateTime date) async {
    return [];
    // _mockScheduleDataSource.getEvents(month);
  }

  @override
  Future<List<DayEvent>> getDayEvents(int teamId, DateTime date) async {
    return [];
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
