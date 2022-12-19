import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/create_event.f.dart';
import 'package:sportly/domain/features/schedule/models/update_event.f.dart';
import 'package:sportly/domain/features/schedule/models/event.f.dart';
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
  Future<List<Event>> getMonthEvents(int teamId, DateTime date) async {
    return [
      Event(
        id: 1,
        date: DateTime(2022, 12, 10, 9, 30),
        title: 'Meeting',
        description: null,
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 13, 9, 30),
        title: 'Match',
        description: null,
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 14, 9, 30),
        title: 'Training',
        description: null,
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 17, 9, 30),
        title: 'Match',
        description: null,
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 17, 9, 30),
        title: 'Match',
        description: null,
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 17, 11, 30),
        title: 'Training',
        description: null,
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 22, 15, 30),
        title: 'Physio',
        description: null,
      ),
    ];
    // _mockScheduleDataSource.getEvents(month);
  }

  @override
  Future<List<Event>> getDayEvents(int teamId, DateTime date) async {
    return [
      Event(
        id: 1,
        date: DateTime(2022, 12, 10, 9, 30),
        title: 'Meeting',
        description: 'Official meeting with staff',
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 14, 11, 30),
        title: 'Training',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 13, 15, 00),
        title: 'Match',
        description: 'Legia Stadium, vs Real Madrid',
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 10, 18, 30),
        title: 'Meeting',
        description: null,
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 14, 20, 30),
        title: 'Training',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
      ),
      Event(
        id: 1,
        date: DateTime(2022, 12, 13, 22, 00),
        title: 'Stretching',
        description: null,
      ),
    ];
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
