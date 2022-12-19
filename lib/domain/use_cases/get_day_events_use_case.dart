import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/day_event.f.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';

@injectable
class GetDayEventsUseCase {
  GetDayEventsUseCase(this._scheduleRepository);

  final ScheduleRepository _scheduleRepository;

  Future<List<DayEvent>> call(int teamId, DateTime date) async =>
      _scheduleRepository.getDayEvents(teamId, date);
}
