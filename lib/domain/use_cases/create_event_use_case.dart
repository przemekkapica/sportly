import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/create_event.f.dart';
import 'package:sportly/domain/features/schedule/schedule_repository.dart';

@injectable
class CreateEventUseCase {
  CreateEventUseCase(this._scheduleRepository);

  final ScheduleRepository _scheduleRepository;

  Future<void> call(int teamId, CreateEvent createEvent) async {
    return await _scheduleRepository.createEvent(teamId, createEvent);
  }
}
