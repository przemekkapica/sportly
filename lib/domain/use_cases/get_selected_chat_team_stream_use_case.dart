import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class GetSelectedChatTeamStreamUseCase {
  GetSelectedChatTeamStreamUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Stream<Team> call() => _teamsRepository.chatTeamIndicatorStream;
}
