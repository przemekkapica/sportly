import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/month_event.f.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';

@injectable
class GetMonthEventsUseCase {
  GetMonthEventsUseCase(this._scheduleRepository);

  final ScheduleRepository _scheduleRepository;

  Future<List<MonthEvent>> call(int teamId, DateTime date) async =>
      _scheduleRepository.getMonthEvents(teamId, date);
}
