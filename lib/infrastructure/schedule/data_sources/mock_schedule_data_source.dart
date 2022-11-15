import 'package:injectable/injectable.dart';
import 'package:sportly/infrastructure/schedule/dtos/create_event_dto.dart';
import 'package:sportly/infrastructure/schedule/dtos/get_events_dto.dart';

@injectable
class MockScheduleDataSource {
  @override
  Future<void> createEvent(CreateEventDto event) {
    // TODO: implement createEvent
    throw UnimplementedError();
  }

  @override
  Future<GetEventsDto> getEvents(int month) {
    // TODO: implement getEvents
    throw UnimplementedError();
  }
}
