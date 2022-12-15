import 'package:injectable/injectable.dart';
import 'package:sportly/infrastructure/schedule/dtos/create_event_dto.dart';
import 'package:sportly/infrastructure/schedule/dtos/get_events_dto.dart';

@injectable
class ScheduleDataSource {
  @override
  Future<void> createEvent(int teamId, CreateEventDto event) async {
    // TODO: implement createEvent
    throw UnimplementedError();
  }

  @override
  Future<GetEventsDto> getDayEvents(int teamId, DateTime date) async {
    // TODO: implement getEvents
    throw UnimplementedError();
  }

  @override
  Future<GetEventsDto> getMonthEvents(int teamId, DateTime date) async {
    // TODO: implement getEvents
    throw UnimplementedError();
  }

  @override
  Future<GetEventsDto> updateEvent(int teamId, DateTime date) async {
    // TODO: implement getEvents
    throw UnimplementedError();
  }
}
