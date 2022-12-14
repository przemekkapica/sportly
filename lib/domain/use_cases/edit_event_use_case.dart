import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/edit_event.f.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';

@injectable
class EditEventUseCase {
  EditEventUseCase(this._scheduleRepository);

  final ScheduleRepository _scheduleRepository;

  Future<void> call(int teamId, EditEvent editEvent) async {
    return await _scheduleRepository.editEvent(teamId, editEvent);
  }
}
