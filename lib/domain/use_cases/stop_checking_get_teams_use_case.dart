import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class StopCheckingGetTeamsUseCase {
  StopCheckingGetTeamsUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  void call() {
    return _teamsRepository.stopCheckingTeams();
  }
}
