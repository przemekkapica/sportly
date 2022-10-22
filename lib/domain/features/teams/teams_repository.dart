import 'package:sportly/domain/features/teams/models/create_team.f.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';

abstract class TeamsRepository {
  Future<void> createTeam(CreateTeam createTeam);

  Future<List<Team>> getTeams();

  Future<TeamDetails> getTeamDetails(String id);
}
