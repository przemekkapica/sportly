import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class FetchTeamsUseCase {
  FetchTeamsUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<void> call() async {
    return await _teamsRepository.fetchTeams();
  }
}
