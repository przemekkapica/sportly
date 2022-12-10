import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/create_event.f.dart';
import 'package:sportly/domain/features/schedule/models/event.f.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';
import 'package:sportly/infrastructure/schedule/data_sources/schedule_data_source.dart';
import 'package:sportly/infrastructure/schedule/mappers/event_bidirectional_mapper.dart';

@LazySingleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl(
    this._scheduleDataSource,
  );

  final ScheduleDataSource _scheduleDataSource;

  @override
  Future<void> createEvent(int teamId, CreateEvent createEvent) async {
    return;
    // _mockScheduleDataSource.createEvent(event)
  }

  @override
  Future<List<Event>> getMonthEvents(int teamId, DateTime date) async {
    return [
      Event(
        date: DateTime(2022, 12, 10, 9, 30),
        title: 'Meeting',
        description: null,
      ),
      Event(
        date: DateTime(2022, 12, 13, 9, 30),
        title: 'Match',
        description: null,
      ),
      Event(
        date: DateTime(2022, 12, 14, 9, 30),
        title: 'Training',
        description: null,
      ),
      Event(
        date: DateTime(2022, 12, 17, 9, 30),
        title: 'Match',
        description: null,
      ),
      Event(
        date: DateTime(2022, 12, 17, 9, 30),
        title: 'Match',
        description: null,
      ),
      Event(
        date: DateTime(2022, 12, 17, 11, 30),
        title: 'Training',
        description: null,
      ),
      Event(
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
        date: DateTime(2022, 12, 10, 9, 30),
        title: 'Meeting',
        description: 'Official meeting with staff',
      ),
      Event(
        date: DateTime(2022, 12, 14, 11, 30),
        title: 'Training',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
      ),
      Event(
        date: DateTime(2022, 12, 13, 15, 00),
        title: 'Match',
        description: 'Legia Stadium, vs Real Madrid',
      ),
    ];
  }
}
