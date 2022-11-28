import 'package:sportly/domain/features/schedule/models/event.f.dart';

abstract class ScheduleRepository {
  Future<List<Event>> getEvents(int teamId, int month);

  Future<void> createEvent(Event event);
}
