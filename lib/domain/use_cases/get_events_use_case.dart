import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/event.f.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';

@injectable
class GetEventsUseCase {
  GetEventsUseCase(this._scheduleRepository);

  final ScheduleRepository _scheduleRepository;

  Future<List<Event>> call(String teamId, int month) =>
      _scheduleRepository.getEvents(teamId, month);
}
