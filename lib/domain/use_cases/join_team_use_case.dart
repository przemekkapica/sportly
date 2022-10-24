import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class JoinTeamUseCase {
  JoinTeamUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<bool> call(String code) async {
    return await _teamsRepository.joinTeam(code);
  }
}
