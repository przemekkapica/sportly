import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class RemoveTeamMemberUseCase {
  RemoveTeamMemberUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<void> call(int teamId, int userId) async {
    return await _teamsRepository.removeTeamMember(teamId, userId);
  }
}
