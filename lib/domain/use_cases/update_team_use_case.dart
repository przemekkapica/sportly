import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/create_team.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class UpdateTeamUseCase {
  UpdateTeamUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<void> call(CreateTeam createTeam) async {
    return await _teamsRepository.createTeam(createTeam);
    // TODO
  }
}
