import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/event.f.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';

@injectable
class GetDayEventsUseCase {
  GetDayEventsUseCase(this._scheduleRepository);

  final ScheduleRepository _scheduleRepository;

  Future<List<Event>> call(int teamId, DateTime date) =>
      _scheduleRepository.getDayEvents(teamId, date);
}
