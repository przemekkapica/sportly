import 'package:sportly/infrastructure/teams/dtos/create_team_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/get_teams_dto.dart';

abstract class TeamsDataSource {
  Future<void> createTeam(CreateTeamDto createTeamDto);

  Future<GetTeamsDto> getTeams();
}
