import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/update_team.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class UpdateTeamUseCase {
  UpdateTeamUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<void> call(int id, UpdateTeam updateTeam) async {
    return await _teamsRepository.updateTeam(id, updateTeam);
  }
}
