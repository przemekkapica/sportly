import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/update_event.f.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';

@injectable
class UpdateEventUseCase {
  UpdateEventUseCase(this._scheduleRepository);

  final ScheduleRepository _scheduleRepository;

  Future<void> call(int teamId, UpdateEvent editEvent) async {
    return await _scheduleRepository.updateEvent(teamId, editEvent);
  }
}
