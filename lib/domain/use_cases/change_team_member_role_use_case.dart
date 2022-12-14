import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class ChangeTeamMemberRoleUseCase {
  ChangeTeamMemberRoleUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<void> call(int teamId, int userId, Role role) async {
    return await _teamsRepository.changeTeamMemberRole(teamId, userId, role);
  }
}
