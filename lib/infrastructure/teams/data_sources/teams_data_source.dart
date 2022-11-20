import 'package:sportly/infrastructure/teams/dtos/create_team_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/get_teams_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/team_details_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/update_team_dto.dart';

abstract class TeamsDataSource {
  Future<void> createTeam(CreateTeamDto createTeamDto);

  Future<GetTeamsDto> getTeams();

  Future<TeamDetailsDto> getTeamDetails(String id);

  Future<bool> joinTeam(String code);

  Future<void> leaveTeam(String id);

  Future<void> updateTeam(String id, UpdateTeamDto updateTeamDto);
}
