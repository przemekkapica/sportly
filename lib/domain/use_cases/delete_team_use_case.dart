import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class DeleteTeamUseCase {
  DeleteTeamUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<void> call(int id) async {
    return await _teamsRepository.deleteTeam(id);
  }
}
