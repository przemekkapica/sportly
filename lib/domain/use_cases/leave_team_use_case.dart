import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class LeaveTeamUseCase {
  LeaveTeamUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<void> call(String id) async {
    return await _teamsRepository.leaveTeam(id);
  }
}
