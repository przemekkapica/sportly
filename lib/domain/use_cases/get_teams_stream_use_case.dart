import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class GetTeamsStreamUseCase {
  GetTeamsStreamUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Stream<List<Team>> call() {
    return _teamsRepository.teamsStream;
  }
}
