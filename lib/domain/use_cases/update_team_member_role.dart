import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class UpdateTeamMemberRoleUseCase {
  UpdateTeamMemberRoleUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<void> call(String teamId, String userId, Role role) async {
    return await _teamsRepository.updateTeamMemberRole(teamId, userId, role);
  }
}
