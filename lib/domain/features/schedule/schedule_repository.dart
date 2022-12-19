import 'package:sportly/domain/features/schedule/models/create_event.f.dart';
import 'package:sportly/domain/features/schedule/models/month_event.f.dart';
import 'package:sportly/domain/features/schedule/models/update_event.f.dart';
import 'package:sportly/domain/features/schedule/models/day_event.f.dart';

abstract class ScheduleRepository {
  Future<List<MonthEvent>> getMonthEvents(int teamId, DateTime date);

  Future<List<DayEvent>> getDayEvents(int teamId, DateTime date);

  Future<void> createEvent(int teamId, CreateEvent createEvent);

  Future<void> updateEvent(int teamId, UpdateEvent editEvent);

  Future<void> deleteEvent(int teamId, int eventId);
}
