import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';

@injectable
class DeleteEventUseCase {
  DeleteEventUseCase(this._scheduleRepository);

  final ScheduleRepository _scheduleRepository;

  Future<void> call(int teamId, int eventId) async {
    return await _scheduleRepository.deleteEvent(teamId, eventId);
  }
}
