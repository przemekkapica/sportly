import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class GetTeamDetailsUseCase {
  GetTeamDetailsUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<TeamDetails> call(int id) async {
    return await _teamsRepository.getTeamDetails(id);
  }
}
